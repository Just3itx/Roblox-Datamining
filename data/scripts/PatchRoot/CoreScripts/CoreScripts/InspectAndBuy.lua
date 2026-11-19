-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local RobloxGui = game:GetService("CoreGui").RobloxGui
local Modules = RobloxGui.Modules
local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local InspectAndBuy = Modules.InspectAndBuy
local Roact = require(CorePackages.Packages.Roact)
local InspectAndBuy2 = require(InspectAndBuy.Components.InspectAndBuy)
local var1 = nil

local renderWithCoreScriptsStyleProvider = require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)

local FFlagAXEnableNewInspectAndBuyContainer = require(InspectAndBuy.Flags.FFlagAXEnableNewInspectAndBuyContainer)

local TopBar = require(RobloxGui.Modules.TopBar)

local FFlagTopBarSignalizeMenuOpen = CoreGuiCommon.Flags.FFlagTopBarSignalizeMenuOpen
local bool1 = game:DefineFastFlag("InspectAndBuyFixStyleLink", false)

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled

local isSpatial = nil
local UIManager = nil
local PanelType = nil
if isInExperienceUIVREnabled then
    isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial

    local vrSpatialUi = require(CorePackages.Workspace.Packages.VrSpatialUi)
    UIManager = vrSpatialUi.UIManager
    PanelType = vrSpatialUi.Constants.PanelType
end

local function mount(humanoidDescription, playerName, playerId, ctx: string)
    if var1 then
        Roact.unmount(var1)
        var1 = nil
    end

    local var2 = renderWithCoreScriptsStyleProvider({
        inspectAndBuy = Roact.createElement(
            InspectAndBuy2,
            {
                humanoidDescription = humanoidDescription,
                playerName = playerName,
                playerId = playerId,
                ctx = ctx
            }
        )
    })
    if FFlagAXEnableNewInspectAndBuyContainer then
        var2 = Roact.createElement(
            InspectAndBuy2,
            {
                humanoidDescription = humanoidDescription,
                playerName = playerName,
                playerId = playerId,
                ctx = ctx
            }
        )
    end
    if bool1 then
        var2 = Roact.createElement("Folder", nil, var2)
    end

    if isInExperienceUIVREnabled and isSpatial() then
        local panelObject = UIManager.getInstance():getPanelObject(PanelType.MoreMenu)
        var1 = Roact.mount(var2, panelObject, "InspectAndBuy")
    else
        var1 = Roact.mount(var2, RobloxGui, "InspectAndBuy")
    end
    GuiService:SetMenuIsOpen(true, "InspectMenu")

    if FFlagTopBarSignalizeMenuOpen then
        CoreGuiCommon.Stores.GetInspectAndBuyStore(false).setInspectAndBuyOpen(true)
        return
    end
    TopBar:setInspectMenuOpen(true)
end

local function unmountInspectAndBuy()
    if not var1 then
        return
    end

    Roact.unmount(var1)
    var1 = nil
    GuiService:SetMenuIsOpen(false, "InspectMenu")

    if FFlagTopBarSignalizeMenuOpen then
        CoreGuiCommon.Stores.GetInspectAndBuyStore(false).setInspectAndBuyOpen(false)
        return
    end
    TopBar:setInspectMenuOpen(false)
end

local function mountInspectAndBuyFromHumanoidDescription(humanoidDescription: Instance, name: string, ctx: string) -- Luacid: Inlined by compiler; 1 call site recovered
    mount(humanoidDescription, name, nil, ctx)
end

local function mountInspectAndBuyFromUserId(userId: number, ctx: string) -- Luacid: Inlined by compiler; 1 call site recovered
    mount(nil, nil, userId, ctx)
end

GuiService.InspectPlayerFromHumanoidDescriptionRequest:Connect(function(humanoidDescription: Instance, name: string)
    mountInspectAndBuyFromHumanoidDescription(humanoidDescription, name, "developerThroughHumanoidDescription")
end)

GuiService.InspectPlayerFromUserIdWithCtxRequest:Connect(function(userId: number, ctx: string)
    mountInspectAndBuyFromUserId(userId, ctx)
end)

GuiService.CloseInspectMenuRequest:Connect(function()
    if var1 then
        unmountInspectAndBuy()
    end
end)

GuiService.InspectMenuEnabledChangedSignal:Connect(function(enabled: boolean)
    if not enabled and var1 then
        unmountInspectAndBuy()
    end
end)
