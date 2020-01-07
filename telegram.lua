#!/usr/bin/env tarantool


local http_client = require('http.client').new({max_connections = 10})
local errors = require('errors')
local checks = require('checks')
local json = require('json')

local BASE_URL = 'https://api.telegram.org/bot%s/%s'

local function call(token, function_name, params)
   checks('string', 'string', 'table')
   local url = string.format(BASE_URL, token, function_name)
   local result = http_client:post(
      url,
      json.encode(params),
      {headers={['Content-Type']='application/json'}})

   local data = json.decode(result.body)

   if data.ok == true then
      return data
   end

   return nil, errors.new(string.format('TelegramError%s', data.error_code),
                          'Telegram request failed: %s', data.description)
end




return {call=call}
