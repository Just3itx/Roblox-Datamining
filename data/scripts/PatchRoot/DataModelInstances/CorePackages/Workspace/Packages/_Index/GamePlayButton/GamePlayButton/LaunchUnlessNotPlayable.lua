-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local GamePlayButtonParent = GamePlayButton.Parent

local FetchGamePlayabilityAndProductInfo = require(GamePlayButtonParent.GameDetailRodux).FetchGamePlayabilityAndProductInfo
local GetFFlagLuaAppFetchPlayabilityKillSwitch = require(GamePlayButton.Flags.GetFFlagLuaAppFetchPlayabilityKillSwitch)

local tbl1 = ({})

local function LaunchUnlessNotPlayable(arg1, str1: string, callback: (...any) -> (...any), callback2: (...any) -> (...any))
    return function(arg2)
        local function routeByPlayability() -- Luacid: Inlined by compiler; 2 call sites recovered
            local var1 = arg2:getState().PlayabilityStatus[str1]
            if var1 and var1.isPlayable == false then
                callback2()
                return
            end
            callback()
        end

        local function settle()
            tbl1[str1] = nil
            routeByPlayability()
        end

        if tbl1[str1] then
            return
        end

        if arg2:getState().PlayabilityStatus[str1] ~= nil then
            routeByPlayability()
            return
        end

        if GetFFlagLuaAppFetchPlayabilityKillSwitch() then
            callback()
        else
            tbl1[str1] = true

            arg2:dispatch(FetchGamePlayabilityAndProductInfo.Fetch(arg1, str1)):andThen(settle, settle)
        end
    end
end
return LaunchUnlessNotPlayable
