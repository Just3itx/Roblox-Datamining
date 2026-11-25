-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent
local React = require(SduiSharedUtilitiesParent.React)
local Signals = require(SduiSharedUtilitiesParent.Signals)
local SduiCoreSystem = require(SduiSharedUtilitiesParent.SduiCoreSystem)
local SduiLogger = SduiCoreSystem.SduiLogger
local SduiErrors = SduiCoreSystem.SduiErrors
local useCollectionLayoutConfig = require(SduiSharedUtilitiesParent.CollectionViews).useCollectionLayoutConfig
local getSduiServiceDependenciesStore = SduiCoreSystem.getSduiServiceDependenciesStore

local CollectionItemSize = require(SduiSharedUtilitiesParent.CollectionViews).CollectionViewTypes.CollectionItemSize

local SharedFlags = require(SduiSharedUtilitiesParent.SharedFlags)
local FFlagLuaAppCompositionAlways = SharedFlags.FFlagLuaAppCompositionAlways
local FFlagLuaAppSduiVideoThumbnail = SharedFlags.FFlagLuaAppSduiVideoThumbnail
local FFlagLuaAppOneByTwoHoverIdleAutoplay = SharedFlags.FFlagLuaAppOneByTwoHoverIdleAutoplay

local tbl1 = {
    numColumns = 3,
    fractionalItemAmount = 0,
    columnGap = 24,
    sideMargin = 24,
    verticalPadding = 16
}

local function useCreateClientBindingSduiContext(appPage: string, arg1, num1: number?, dataUpdatedTimestamp: number?, configKey: string?, bool1: boolean?, str3: string?, scrollAway, videoPlaybackContext)
    local routeName = str3 or appPage
    local var1 = nil
    local var2 = nil
    if not FFlagLuaAppCompositionAlways then
        var1 = useCollectionLayoutConfig(arg1, num1)
        var2 = React.useCallback(function(arg3)
            return Signals.createComputed(function(arg4)
                if bool1 ~= false then
                    return tbl1
                end
                if var1 then
                    return (var1[arg3] or var1[CollectionItemSize.Small])(arg4)
                end
                SduiLogger.reportError(
                    SduiErrors.SduiErrorType.NoPageLayoutConfig,
                    {
                        message = `No page layout config available for {appPage}, returning default config`
                    },
                    appPage
                )
                return tbl1
            end)
        end, { var1, appPage, bool1 })
    end

    local useMemo = React.useMemo
    local function func1()
        return {
            dependencies = getSduiServiceDependenciesStore().getDependencies(appPage),
            appPage = appPage,
            routeName = routeName,
            getPageLayoutConfig = var2,
            appCompositionEnabled = bool1 == nil or bool1,
            dataUpdatedTimestamp = dataUpdatedTimestamp,
            configKey = configKey,
            scrollAway = scrollAway,
            videoPlaybackContext = if FFlagLuaAppSduiVideoThumbnail or FFlagLuaAppOneByTwoHoverIdleAutoplay then videoPlaybackContext else nil
        }
    end

    local var3 = var2
    local var4 = if FFlagLuaAppSduiVideoThumbnail or FFlagLuaAppOneByTwoHoverIdleAutoplay then videoPlaybackContext else nil
    return (useMemo(func1, { appPage, routeName, var3, dataUpdatedTimestamp, configKey, bool1, scrollAway, var4 }))
end

return useCreateClientBindingSduiContext
