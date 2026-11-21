-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local AppPage = require(GamePlayButtonParent.RobloxAppEnums).AppPage
local Selectors = require(GamePlayButtonParent.NavigationRodux).Selectors
local NavigateBack = require(GamePlayButtonParent.NavigationRodux).Thunks.NavigateBack
local AccessResponseEnum = require(GamePlayButtonParent.AmpUpsell).AmpEnums.AccessResponseEnum
local FFlagSignalsNavP3Dispatch = require(GamePlayButtonParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(GamePlayButtonParent.RobloxAppNavigation).NavigationCommands else nil
local GetLegacyNavigationStore = if FFlagSignalsNavP3Dispatch then require(GamePlayButtonParent.NavigationRodux).GetLegacyNavigationStore else nil

return function(callback: (...any) -> (...any), num1: number): ((any, any, any) -> ())?
    return if num1 and num1 > 0 then function(arg1, granted, arg2)
        if not (arg1 and arg1.getState and arg1.dispatch) then
            return
        end

        if granted ~= AccessResponseEnum.Granted then
            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.back(true)
            else
                arg1:dispatch(NavigateBack(true))
            end
            callback(granted, arg2)
            return
        end

        task.delay(num1 / 1000, function()
            if (if FFlagSignalsNavP3Dispatch then GetLegacyNavigationStore(false).getCurrentPageName(false) else Selectors.selectCurrentPageName(arg1:getState())) == AppPage.AmpWizardContainer then
                if FFlagSignalsNavP3Dispatch then
                    NavigationCommands.back(true)
                else
                    arg1:dispatch(NavigateBack(true))
                end
            end
            callback(granted, arg2)
        end)
    end else nil
end
