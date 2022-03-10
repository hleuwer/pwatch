#!/usr/bin/env lua
local notify = require "inotify"
local pretty = require "pl.pretty"
local logging = require "logging"
require "logging.rolling_file"
local conf = loadfile("/etc/pwatch.conf")()
local wdname = conf.wdname
local logfilename = conf.logfilename
local printopts = conf.printopts
local fmt = string.format
local logger = logging.rolling_file{
	filename = logfilename,
	maxFileSize = 32*1024,
	maxBackupIndex = 5
}
local function usage(args)
   print([[
usage: pwatch OPTIONS
  OPTIONS:
  --help   Print this help.
  --test   Run in test mode.
]])
end

local function main(args)
   local dotest = false
   -- parse arguments
   for _, arg in ipairs(args) do
      if arg == "--help" then
         usage(args)
         os.exit(0)
      elseif arg == "--test" then
         dotest = true
      end
   end
   local handle = notify.init()
   local wd = handle:addwatch(wdname, notify.IN_CREATE, notify.IN_MOVE)
   if dotest == false then
      logger:setLevel(logging.INFO)
      logger:info("Printer Watch Job started")
      logger:info(fmt("Watching directory %q\n", wdname))
   else
      print("Running in test mode - logging is turned off.")
   end
   while true do
      local events = handle:read()
      for _, ev in ipairs(events) do
         if ev.mask == notify.IN_MOVED_TO then
            local t = {
               "lp",
               printopts,
               wdname .. "/" ..string.gsub(ev.name, "(%s+)", "\\ "),
               "2>&1"
            }
            local cmd = table.concat(t, " ")
            if dotest == true then
               print(cmd)
            else
               logger:info(fmt("Printing file %q", ev.name))
               local res = io.popen(cmd):read("*a")
               logger:info(fmt("done: %s", res))
            end
         end
      end
   end
end

main{select(1, ...)}
os.exit(0)
