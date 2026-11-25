-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent

local React = require(SduiCoreSystemParent.React)
local Signals = require(SduiCoreSystemParent.Signals)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiConditionalPropTypes = require(SduiCoreSystem.ConditionalProps.SduiConditionalPropTypes)
local checkPresenceConditions = require(SduiCoreSystem.ConditionalProps.checkPresenceConditions)

return React.memo(function(tbl1) -- name: SduiPresenceDetector
    local allConditionalProps = tbl1.allConditionalProps
    local setFailedPresencePropIndexes = tbl1.setFailedPresencePropIndexes
    local getInGameFriendsByGame = tbl1.sduiContext.dataStore.social.getInGameFriendsByGame

    React.useLayoutEffect(function()
        local tbl2 = {}

        local function checkConditions(tbl3)
            local var1 = checkPresenceConditions(allConditionalProps, tbl3)

            local var2 = nil
            for value, value2 in var1 do
                if not not tbl2[value] ~= not not value2 then
                    var2 = true
                    break
                end
            end

            if not var2 then
                for value, value2 in tbl2 do
                    if not not var1[value] ~= not not value2 then
                        var2 = true
                        break
                    end
                end
            end

            if var2 then
                tbl2 = var1
                setFailedPresencePropIndexes(var1)
            end
        end

        checkConditions(getInGameFriendsByGame(false))

        return Signals.createEffect(function(arg1)
            checkConditions(getInGameFriendsByGame(arg1))
        end)
    end, { getInGameFriendsByGame, allConditionalProps, setFailedPresencePropIndexes })

    return nil
end)
