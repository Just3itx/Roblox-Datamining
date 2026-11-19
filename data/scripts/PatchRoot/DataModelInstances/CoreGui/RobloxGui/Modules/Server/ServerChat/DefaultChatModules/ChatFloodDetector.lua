-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ClientChatModules = game:GetService("Chat"):WaitForChild("ClientChatModules")
local ChatConstants = require(ClientChatModules:WaitForChild("ChatConstants"))

local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserAddChatThrottlingToAllChannels")
end)
if not success then
    result = false
end

local bool1 = not result

local tbl1 = ({})
local tbl2 = {}

local var1 = nil

pcall(function()
    var1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

var1 = var1 == nil and {} or var1

if not (var1.FormatMessageToSend and var1.LocalizeFormattedMessage) then
    function var1.FormatMessageToSend<T>(_, _, arg1: T): T
        return arg1
    end
end

local function EnterTimeIntoLog(tbl3: {any}) -- Luacid: Inlined by compiler; 1 call site recovered
    table.insert(tbl3, tick() + 15)
end

local function Run(arg1)
    arg1:RegisterProcessCommandsFunction("flood_detection", function(arg2, _, arg3): boolean -- name: FloodDetectionProcessCommandsFunction
        if tbl2[arg2] then
            return false
        end
        local speaker = arg1:GetSpeaker(arg2)
        if not speaker then
            return false
        end

        if not speaker:GetPlayer() then
            return false
        end
        if not tbl1[arg2] then
            tbl1[arg2] = {}
        end

        local var2

        if bool1 then
            if not tbl1[arg2][arg3] then
                tbl1[arg2][arg3] = {}
            end

            var2 = tbl1[arg2][arg3]
        else
            var2 = tbl1[arg2]
        end

        local now = tick()
        while #var2 > 0 and var2[1] < now do
            table.remove(var2, 1)
        end

        if #var2 < 7 then
            EnterTimeIntoLog(var2)
            return false
        end

        local num1 = math.ceil(var2[1] - now)

        speaker:SendSystemMessage(
            var1:FormatMessageToSend(
                "GameChat_ChatFloodDetector_MessageDisplaySeconds",
                string.format("You must wait %d %s before sending another message!", num1, if num1 > 1 then "seconds" else "second"),
                "RBX_NUMBER",
                tostring(num1)
            ),
            arg3
        )

        return true
    end, ChatConstants.LowPriority)

    arg1.SpeakerRemoved:connect(function(arg2)
        tbl1[arg2] = nil
    end)
end

return Run
