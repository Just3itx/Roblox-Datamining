-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local appShortcutBar = script:FindFirstAncestor("AppShortcutBar")
local appShortcutBarParent = appShortcutBar.Parent
local React = require(appShortcutBarParent.React)
local Responsive = require(appShortcutBarParent.Responsive)
local UIBlox = require(appShortcutBarParent.UIBlox)
local useFocusedTextBox = require(appShortcutBarParent.FocusNavigationUtils).useFocusedTextBox
local ShortcutBar = UIBlox.App.Navigation.ShortcutBar
local bool1 = game:DefineFastFlag("DisableAppShortcutBarAndroidTV", false)

local FFlagEnableStickyShortcutBarOnAllPlatformsIxpEnabled = require(appShortcutBar.Flags).FFlagEnableStickyShortcutBarOnAllPlatformsIxpEnabled
local FFlagUnifyShortcutBarUnifiedIXPExposure = require(appShortcutBarParent.SharedFlags).FFlagUnifyShortcutBarUnifiedIXPExposure
local useStickyShortcutBarExposureLogging = require(appShortcutBar.Hooks.useStickyShortcutBarExposureLogging)

function AppShortcutBar(tbl1)
    local position = if tbl1.Position then tbl1.Position else UDim2.fromScale(0.5, 0)
    local anchorPoint = if tbl1.AnchorPoint then tbl1.AnchorPoint else Vector2.new(0.5, 0)
    local var3 = useFocusedTextBox()
    local var4 = Responsive.useLastInput()
    local var5, var6 = React.useState(
        var4 ~= Responsive.Input.Directional
            or UserInputService:GamepadSupports(UserInputService:GetLastInputType(), Enum.KeyCode.Thumbstick1)
    )

    if bool1 then
        React.useEffect(function()
            local connection = UserInputService.LastInputTypeChanged:Connect(function()
                var6(
                    var4 ~= Responsive.Input.Directional
                        or UserInputService:GamepadSupports(UserInputService:GetLastInputType(), Enum.KeyCode.Thumbstick1)
                )
            end)

            return function()
                connection:Disconnect()
            end
        end, { var4 })
    end

    local var7 = #tbl1.items > 0 and not var3 and (not bool1 or var5)
    local bool2 = not Responsive.useBreakpointXOrSmaller(Responsive.Keys.Small)
    local bool3 = not Responsive.useBreakpointYOrSmaller(Responsive.Keys.XSmall)
    local var8 = var7 and bool2 and bool3

    if FFlagEnableStickyShortcutBarOnAllPlatformsIxpEnabled and not FFlagUnifyShortcutBarUnifiedIXPExposure then
        useStickyShortcutBarExposureLogging(var8)
    end

    return React.createElement(
        "Frame",
        {
            Position = UDim2.fromScale(0, 0),
            Size = if tbl1.Size then tbl1.Size else UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        },
        if var8 then React.createElement(ShortcutBar, { items = tbl1.items, position = position, anchorPoint = anchorPoint }) else nil
    )
end

return AppShortcutBar
