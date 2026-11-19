-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")
local t = require(CorePackages.Packages.t)
local Roact = require(CorePackages.Packages.Roact)
local Foundation = require(CorePackages.Packages.Foundation)

local BlockingModalContainer = require(script.Parent.BlockingModalContainer)
local renderWithCoreScriptsStyleProvider = require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)

local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local useOverlay = Foundation.Hooks.useOverlay

local var1 = Roact.PureComponent:extend("BlockingModalScreen")

var1.validateProps = t.interface({
    closeModal = t.callback,
    player = t.interface({ DisplayName = t.string, Name = t.string, UserId = t.number }),
    translator = t.optional(t.table),
    source = t.optional(t.string),
    onBlockingSuccess = t.optional(t.callback),
    overlay = t.optional(t.instanceIsA("GuiBase2d"))
})

function var1.render(arg1)
    local overlay = arg1.props.overlay

    local element = Roact.createElement(
        FocusRoot,
        {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
            isIsolated = true,
            isAutoFocusRoot = true
        },
        {
            BlockingModalContainerWrapper = Roact.createElement(BlockingModalContainer, arg1.props)
        }
    )

    local tbl1 = overlay == nil
        and { Roact.createElement(Roact.Portal, { target = CoreGui }, {
                BlockingModalScreen = Roact.createElement(
                    "ScreenGui",
                    { IgnoreGuiInset = true, AutoLocalize = false, DisplayOrder = 6 },
                    { BlockingModalContainer = element }
                )
            }) }
        or { Roact.createElement(Roact.Portal, { target = overlay }, { BlockingModalScreen = element }) }

    return renderWithCoreScriptsStyleProvider(tbl1)
end

local function BlockingModalScreenWithFoundationOverlay(arg1)
    local overlay = useOverlay()
    local var3 = table.clone(arg1)
    var3.overlay = overlay

    return Roact.createElement(var1, var3)
end

return BlockingModalScreenWithFoundationOverlay
