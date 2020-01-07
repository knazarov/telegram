# Telegram bot API for Tarantool

This is a simplistic, one-function library to interact with a telegram
bot from Tarantool. You will likely be better off just copying this
function into your project's source tree.

See [Official Telegram API documentation](https://core.telegram.org/bots/api) for reference.

## Usage

Sending messages:

```lua
local telegram = require('telegram')

local BOT_TOKEN = 'my-bot-token'

local chat_id = 123456 -- This would be a chat ID with individual user or a groupchat
local message = 'Hello, world!'

local res, err = telegram.call('sendMessage', {chat_id=chat_id, message=message})

if res == nil then
    print(err)
    os.exit(1)
end
```


Getting updates:

```lua
local telegram = require('telegram')

local update_id = 0
local BOT_TOKEN = 'my-bot-token'

while true do
    -- use long-polling with 10-second timeout
    local params = {timeout = 10}

    if update_id ~= 0 then
        params.offset = update_id + 1
    end

    local res, err = telegram.call(BOT_TOKEN, 'getUpdates', params)

    if res == nil then
        print(err)
        os.exit(1)
    end

    for _, entry in ipairs(res.result) do
        -- Handle every 'entry' here

        update_id = math.max(entry.update_id, update_id)
    end
end

```
