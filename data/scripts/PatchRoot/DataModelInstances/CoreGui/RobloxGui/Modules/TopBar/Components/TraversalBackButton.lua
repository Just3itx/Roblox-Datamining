-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TeleportService = game:GetService("TeleportService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local ReactOtter = require(CorePackages.Packages.ReactOtter)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local CoreScriptsCommon = require(CorePackages.Workspace.Packages.CoreScriptsCommon)
local CoreScriptsRoactCommon = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon)
local DataHydration = require(CorePackages.Workspace.Packages.DataHydration)
local Localization = require(CorePackages.Workspace.Packages.Localization)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local SettingsShowSignal = CoreScriptsCommon.SettingsShowSignal
local Traversal = CoreScriptsRoactCommon.Traversal
local DataHydrationTypes = DataHydration.DataHydrationTypes
local getGameInfoStore = DataHydration.Game.getGameInfoStore
local Constants = Traversal.Constants
local TeleportBackButton = Traversal.TeleportBackButton
local TraversalTelemetry = Traversal.TraversalTelemetry
local _useHistoryItems = Traversal.useHistoryItems
local useLocalization = Localization.Hooks.useLocalization

local _FFlagUseTeleportTraversalHistory = Traversal.Flags.FFlagUseTeleportTraversalHistory
local _FFlagUseLocalTraversalHistory = Traversal.Flags.FFlagUseLocalTraversalHistory
local FFlagAddTraversalBackButtonAnimation = Traversal.Flags.FFlagAddTraversalBackButtonAnimation
local bool1 = game:DefineFastFlag("FixTraversalBackButtonAnimation", false)

return React.memo(function(_) -- name: TraversalBackButton
    local var1 = useTokens()
    local ref = React.useRef(nil)
    local destinationUniverseId, var4 = TeleportService:GetThirdPartyTeleportInfo(false)

    if destinationUniverseId <= Constants.NO_UNIVERSE_ID or var4 <= Constants.NO_PLACE_ID then
        return nil
    end

    local var5, var6 = React.useState(false)
    React.useEffect(function()
        local connection = SettingsShowSignal:connect(function(arg1)
            var6(arg1)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    React.useEffect(function()
        if not var5 then
            return
        end

        TraversalTelemetry.sendBackButtonActionEvent(
            {
                integration_id = "back_button",
                destination_universe_id = destinationUniverseId,
                event_type = "impression"
            }
        )
    end, { var5, destinationUniverseId })

    local var7 = useLocalization({ defaultBackButtonText = "CoreScripts.TopBar.Traversal.BackButtonDefault" })

    local var8 = React.useCallback(function(arg1)
        local var8 = getGameInfoStore(arg1).getAndFetchGameInfo(tostring(destinationUniverseId))
        local var9 = var8.data(arg1)
        local var10 = var8.status(arg1)
        return if var9 and var10 == DataHydrationTypes.DataStatus.Ready then var9.name else var7.defaultBackButtonText
    end, { destinationUniverseId, getGameInfoStore })
    local var9 = SignalsReact.useSignalState(var8)

    local var10 = if bool1 then React.useRef(nil) else nil

    local textLimitWidth = var1.Size.Size_2500 * 2
    local var12 = nil
    local var13 = nil
    local var14 = nil
    local var15 = nil
    local var16 = nil
    local var17, var18

    if FFlagAddTraversalBackButtonAnimation then
        var12 = React.useRef(nil)
        var13 = React.useRef(nil)
        if bool1 then
            var14 = React.useRef(nil)
        end
        local var19 = React.useMemo(function()
            return {
                duration = var1.Time.Time_300,
                easingStyle = var1.Ease.StandardOut
            }
        end, { var1 })

        local var20

        var15, var20 = ReactOtter.useAnimatedBinding(0, function(num1: number)
            var12.current = nil
            if not bool1 then
                var13.current = nil
                return
            end

            if not var14.current and var13.current and num1 == 1 then
                var14.current = var13.current
            end
            if num1 == 0 then
                var13.current = 0
            end
        end)

        var16 = var20

        React.useEffect(function()
            if var5 then
                if bool1 then
                    if var10.current ~= var9 then
                        var14.current = nil
                        var10.current = var9
                        if ref.current then
                            var16(ReactOtter.ease(0.99, var19))
                        end
                    else
                        var16(ReactOtter.ease(1, var19))
                    end
                else
                    var16(ReactOtter.ease(1, var19))
                end
            else
                var16(ReactOtter.ease(0, var19))
            end
            if bool1 and var10.current == nil then
                var10.current = var9
            end
        end, { var5, var19, var9 })
        var17 = React.useCallback(function(num1: number)
            if not bool1 then
                if var5 and ref.current then
                    local absoluteSizeX = ref.current.AbsoluteSize.X
                    if not var12.current then
                        var12.current = ref.current.AbsoluteSize.X
                    end
                    if var13.current and absoluteSizeX <= var13.current then
                        return UDim2.new(0, var13.current, 0, 0)
                    end
                    if var12.current and var12.current ~= absoluteSizeX then
                        var13.current = absoluteSizeX
                    end
                end
                local xOffset = num1 * textLimitWidth
                return UDim2.new(0, xOffset, 0, 0)
            end

            if var14.current then
                return UDim2.new(0, num1 * var14.current, 0, 0)
            end

            local xOffset

            if var5 and ref.current then
                local absoluteSizeX = ref.current.AbsoluteSize.X
                if not var12.current then
                    var12.current = ref.current.AbsoluteSize.X
                end

                if var13.current and absoluteSizeX <= var13.current then
                    local new = UDim2.new
                    local num2 = 0

                    if not bool1 then
                        absoluteSizeX = var13.current
                    end

                    return new(num2, absoluteSizeX, 0, 0)
                end
                if var12.current and var12.current ~= absoluteSizeX then
                    var13.current = absoluteSizeX
                end
                xOffset = num1 * textLimitWidth
            else
                xOffset = num1 * (var13.current or textLimitWidth)
            end
            return UDim2.new(0, xOffset, 0, 0)
        end, { var5 })
        var18 = React.useCallback(function(arg1)
            return arg1 > 0 or var5
        end, { var5 })
    else
        var18 = nil
        var17 = nil
    end

    if not FFlagAddTraversalBackButtonAnimation or UserGameSettings.ReducedMotion then
        return var5
            and React.createElement(View, { tag = "auto-xy shrink" }, {
                TraversalBackButton = React.createElement(TeleportBackButton, { text = var9, textLimitWidth = textLimitWidth, ref = ref })
            })
    end

    return React.createElement(
        View,
        {
            tag = "auto-y",
            Visible = var15:map(var18),
            Size = var15:map(var17),
            ZIndex = -1
        },
        {
            TraversalBackButton = React.createElement(TeleportBackButton, { text = var9, textLimitWidth = textLimitWidth, ref = ref })
        }
    )
end)
