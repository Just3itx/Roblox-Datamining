-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrSpatialUi = script:FindFirstAncestor("VrSpatialUi")
local HttpService = game:GetService("HttpService")
local UIManager = require(VrSpatialUi.UIManager)
local Constants = require(VrSpatialUi.Constants)

local FFlagEnableSpatialUIBottomBarFixPlaceFilter = require(VrSpatialUi.Flags.FFlagEnableSpatialUIBottomBarFixPlaceFilter)

local function createInertDecoy(partName: string, parent) -- Luacid: Inlined by compiler; 3 call sites recovered
    local part = Instance.new("Part")
    part.Name = partName
    part.Anchored = true
    part.CanCollide = false
    part.CanTouch = false
    part.CanQuery = false
    part.CastShadow = false
    part.Transparency = 1
    part.Size = Vector3.new(0.05, 0.05, 0.05)
    part:SetAttribute("_isProtectedSpatialUIPart", true)
    part.Parent = parent
end

local function renameAndProtectPart(adornee) -- Luacid: Inlined by compiler; 2 call sites recovered
    if adornee:GetAttribute("_isProtectedSpatialUIPart") then
        return
    end
    local adorneeName = adornee.Name
    local adorneeParent = adornee.Parent
    adornee:SetAttribute("_isProtectedSpatialUIPart", true)
    adornee.Name = HttpService:GenerateGUID(false)
    createInertDecoy(adorneeName, adorneeParent)
end

local function setupBottomBarRuntime(current) -- Luacid: Inlined by compiler; 1 call site recovered
    if current == nil then
        return
    end
    local adornee = current.Adornee
    if adornee == nil then
        return
    end

    renameAndProtectPart(adornee)
end

return function(tbl1, panelType, arg1, keepVisibleWhenTopBarHidden: boolean?)
    local uiGroup = Constants.ROACT_PANEL_UIGROUP_MAP[panelType]
    local cameraFixedPanelProp = uiGroup and {
        uiGroupElementOffset = Constants.ROACT_PANEL_UIGROUP_ELEMENT_OFFSET_MAP[panelType]
    } or nil

    local tbl2 = {
        keepVisibleWhenTopBarHidden = keepVisibleWhenTopBarHidden,
        panelObject = tbl1.current,
        uiType = Constants.SpatialUIType.SpatialUIRoact,
        panelType = panelType,
        headScale = 1,
        panelPositionProps = { uiGroup = uiGroup, cameraFixedPanelProp = cameraFixedPanelProp }
    }

    if FFlagEnableSpatialUIBottomBarFixPlaceFilter and panelType == Constants.PanelType.BottomBar then
        setupBottomBarRuntime(tbl1.current)
    end

    UIManager.getInstance():registerRoactPanel(panelType, tbl2, arg1)
end
