-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrSpatialUiParent = script:FindFirstAncestor("VrSpatialUi").Parent
local InExperienceUIVRIXP = require(VrSpatialUiParent.SharedExperimentDefinition).InExperienceUIVRIXP
local isInExperienceUIVREnabled = require(VrSpatialUiParent.SharedExperimentDefinition).isInExperienceUIVREnabled
local LuauPolyfill = if isInExperienceUIVREnabled then require(VrSpatialUiParent.LuauPolyfill) else nil
local vector2 = Vector2.new(0, 0)
local cFrame = CFrame.new(0, 0, 0)

local num1 = game:DefineFastInt("SpatialUIResolutionScale", 100) / 100
local PANEL_TO_DRAGBAR = game:DefineFastInt("SpatialUIPanelDragBarDistance", 10)
local num3 = game:DefineFastInt("SpatialUIPanelZOffset", 100)
local FFlagEnableInExperienceUIPCVRFix = require(VrSpatialUiParent.SharedFlags).FFlagEnableInExperienceUIPCVRFix

local num4 = game:DefineFastInt("SpatialUIChromeSubMenuHeight", 448)

local SpatialUIType = {
    ScreenUI = "ScreenUI",
    SpatialUI = "SpatialUI",
    SpatialUIPartOnly = "SpatialUIPartOnly",
    SpatialUIRoact = "SpatialUIRoact"
}

local PanelType = {
    Chat = "Chat",
    RobloxGui = "RobloxGui",
    BottomBar = "BottomBar",
    MoreMenu = "MoreMenu",
    ChromeSubMenu = "ChromeSubMenu",
    ToolTipsContainer = "ToolTipsContainer"
}

local SpatialUIGroupType = {
    MainUIGroup = "MainUIGroup",
    MenuUIGroup = "MenuUIGroup",
    ChatUIGroup = "ChatUIGroup",
    ChromeSubMenuUIGroup = "ChromeSubMenuUIGroup",
    WristUIGroup = "WristUIGroup"
}

local VR_PANEL_RESOLUTION_MULTIPLIER = 800 / num1

local function pixelToScaledSize(num6: number): number -- Luacid: Inlined by compiler; 26 call sites recovered
    return num6 / VR_PANEL_RESOLUTION_MULTIPLIER
end

local function getScaledResolutionForPart(num6: number, num7: number): Vector2 -- Luacid: Inlined by compiler; 6 call sites recovered
    return Vector2.new(pixelToScaledSize(num6), (pixelToScaledSize(num7)))
end

local function panelDistanceWithSpacing(vector2_2: Vector2, vector2_3: Vector2, num6: number): Vector2 -- Luacid: Inlined by compiler; 7 call sites recovered
    local num7 = pixelToScaledSize(num6)
    local x = vector2_2.X * 0.5 + vector2_3.X * 0.5 + num7
    local y = vector2_2.Y * 0.5 + vector2_3.Y * 0.5 + num7
    return Vector2.new(x, y)
end

local function alignPanelLeftToAnchor(vector2_2: Vector2, vector2_3: Vector2) -- Luacid: Inlined by compiler; 1 call site recovered
    return vector2_3.X * 0.5 - vector2_2.X * 0.5
end

local function alignPanelTopToAnchor(vector2_2: Vector2, vector2_3: Vector2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return vector2_2.Y * 0.5 - vector2_3.Y * 0.5
end

local function alignPanelBottomToAnchor(vector2_2: Vector2, vector2_3: Vector2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return vector2_3.Y * 0.5 - vector2_2.Y * 0.5
end

local function getAdditionalZOffsetIfNeeded(): number -- Luacid: Inlined by compiler; 4 call sites recovered
    return if InExperienceUIVRIXP:isMovePanelToCenter() then num3 / 1000 else 0
end

local tbl4 = {
    PANEL_TO_PANEL = 10,
    PANEL_TO_BOTTOMBAR = 10,
    PANEL_TO_DRAGBAR = PANEL_TO_DRAGBAR,
    PANEL_TO_CHROME_BOTTOM_OFFSET = 24
}

local function getPanelAroundLeftOrRightEdgeRotation(vector2_2: Vector2, num6: number)
    local x = vector2_2.X * 0.5 + pixelToScaledSize(tbl4.PANEL_TO_PANEL) * 0.5
    local vec3 = if num6 > 0 then Vector3.new(x, 0, 0) else Vector3.new(-1 * x, 0, 0)
    local cFrame2 = CFrame.new(vec3)
    local cFrame3 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.rad(num6))
    local cFrame4 = CFrame.new(-vec3)
    return cFrame2 * cFrame3 * cFrame4
end

local partSize = if isInExperienceUIVREnabled then getScaledResolutionForPart(943, 640) else Vector2.new(0.532, 0.3395) * (10 / 3)
local var1 = if isInExperienceUIVREnabled then getScaledResolutionForPart(434, 264) else Vector2.new(0.1365, 0.1995) * (10 / 3)
local var2 = if isInExperienceUIVREnabled then getScaledResolutionForPart(800, 640) else Vector2.new(0.532, 0.3395) * (10 / 3)
local vector2_2 = if isInExperienceUIVREnabled then getScaledResolutionForPart(317, if FFlagEnableInExperienceUIPCVRFix then num4 else 292) else vector2
local vector2_3 = if isInExperienceUIVREnabled then getScaledResolutionForPart(943, 64) else vector2
local vector2_4 = if isInExperienceUIVREnabled then Vector2.new(vector2_3.X, (pixelToScaledSize(120))) else vector2
local vector2_5 = if isInExperienceUIVREnabled then getScaledResolutionForPart(296, 40) else vector2
local tbl5 = if isInExperienceUIVREnabled then {
    [SpatialUIGroupType.MenuUIGroup] = getPanelAroundLeftOrRightEdgeRotation(var2, if InExperienceUIVRIXP:isMovePanelToCenter() then 0 else 15),
    [SpatialUIGroupType.ChatUIGroup] = getPanelAroundLeftOrRightEdgeRotation(var1, if InExperienceUIVRIXP:isMovePanelToCenter() then 0 else -15)
} else {}
local var4

if isInExperienceUIVREnabled then
    var4 = CFrame.new(
        if InExperienceUIVRIXP:isMovePanelToCenter() then 0 else -1 * panelDistanceWithSpacing(partSize, var2, tbl4.PANEL_TO_PANEL).X,
        alignPanelTopToAnchor(partSize, var2),
        (getAdditionalZOffsetIfNeeded())
    )
        * tbl5[SpatialUIGroupType.MenuUIGroup]
else
    var4 = CFrame.new(0.4, -0.36, 0) * CFrame.Angles(0, math.pi, 0)
end

local var5

if isInExperienceUIVREnabled then
    var5 = CFrame.new(
        if InExperienceUIVRIXP:isMovePanelToCenter() then alignPanelLeftToAnchor(partSize, var1) else panelDistanceWithSpacing(partSize, var1, tbl4.PANEL_TO_PANEL).X,
        alignPanelTopToAnchor(partSize, var1),
        (getAdditionalZOffsetIfNeeded())
    )
        * tbl5[SpatialUIGroupType.ChatUIGroup]
else
    var5 = CFrame.new(partSize.X * 0.5 + var1.X * 0.5 + 1 / 15, (partSize.Y - var1.Y) / 2, 0)
end

local uiGroupElementOffset = if isInExperienceUIVREnabled then CFrame.new(
    0,
    alignPanelBottomToAnchor(partSize, vector2_2) + pixelToScaledSize(tbl4.PANEL_TO_CHROME_BOTTOM_OFFSET),
    (getAdditionalZOffsetIfNeeded())
) * CFrame.Angles(0, math.pi, 0) else cFrame

if isInExperienceUIVREnabled then
    cFrame = CFrame.new(
        0,
        alignPanelBottomToAnchor(partSize, vector2_4) - pixelToScaledSize(tbl4.PANEL_TO_BOTTOMBAR),
        (getAdditionalZOffsetIfNeeded())
    ) * CFrame.Angles(0, math.pi, 0)
end

local tbl6 = {}
local tbl7 = {
    type = SpatialUIType.SpatialUI,
    spatialPanelProps = {
        name = "ExperienceChat",
        faceCamera = true,
        lerp = true,
        partSize = var1,
        virtualScreenSize = var1 * VR_PANEL_RESOLUTION_MULTIPLIER
    }
}
tbl6[PanelType.Chat] = tbl7

tbl6[PanelType.RobloxGui] = {
    type = SpatialUIType.SpatialUIPartOnly,
    spatialPanelProps = {
        name = "RobloxGuiPanel-PartOnly",
        faceCamera = true,
        lerp = true,
        partSize = partSize,
        transparency = 0.5
    }
}

if isInExperienceUIVREnabled then
    tbl6 = LuauPolyfill.Object.assign(tbl6, {
        [PanelType.MoreMenu] = {
            type = SpatialUIType.SpatialUI,
            spatialPanelProps = {
                name = "MoreMenu",
                faceCamera = true,
                lerp = true,
                partSize = var2,
                virtualScreenSize = var2 * VR_PANEL_RESOLUTION_MULTIPLIER
            }
        },
        [PanelType.ChromeSubMenu] = {
            type = SpatialUIType.SpatialUI,
            spatialPanelProps = {
                name = "ChromeSubMenu",
                faceCamera = true,
                lerp = true,
                partSize = vector2_2,
                virtualScreenSize = vector2_2 * VR_PANEL_RESOLUTION_MULTIPLIER
            }
        },
        [PanelType.ToolTipsContainer] = {
            type = SpatialUIType.SpatialUI,
            spatialPanelProps = {
                name = "ToolTipsContainer",
                faceCamera = true,
                lerp = true,
                partSize = vector2_4,
                virtualScreenSize = vector2_4 * VR_PANEL_RESOLUTION_MULTIPLIER
            }
        }
    })
end

local tbl8 = {
    [PanelType.Chat] = {
        uiGroup = if isInExperienceUIVREnabled then SpatialUIGroupType.ChatUIGroup else SpatialUIGroupType.MainUIGroup,
        cameraFixedPanelProp = { uiGroupElementOffset = var5 }
    },
    [PanelType.RobloxGui] = {
        uiGroup = SpatialUIGroupType.MainUIGroup,
        cameraFixedPanelProp = {
            uiGroupElementOffset = CFrame.new(0, 0, 0)
        }
    }
}
if isInExperienceUIVREnabled then
    tbl8 = LuauPolyfill.Object.assign(tbl8, {
        [PanelType.MoreMenu] = {
            uiGroup = SpatialUIGroupType.MenuUIGroup,
            cameraFixedPanelProp = { uiGroupElementOffset = var4 }
        },
        [PanelType.ChromeSubMenu] = {
            uiGroup = SpatialUIGroupType.ChromeSubMenuUIGroup,
            cameraFixedPanelProp = { uiGroupElementOffset = uiGroupElementOffset }
        },
        [PanelType.ToolTipsContainer] = {
            uiGroup = SpatialUIGroupType.MainUIGroup,
            cameraFixedPanelProp = { uiGroupElementOffset = cFrame }
        }
    })
end

local var7

if isInExperienceUIVREnabled then
    var7 = CFrame.new(0, -1 * panelDistanceWithSpacing(partSize, vector2_3, tbl4.PANEL_TO_BOTTOMBAR).Y, 0) * CFrame.Angles(0, math.pi, 0)
else
    var7 = CFrame.new(0, -partSize.Y * 0.5 - 0.075 - 1 / 30, 0) * CFrame.Angles(0, math.pi, 0)
end

local tbl10 = {
    [PanelType.BottomBar] = SpatialUIGroupType.MainUIGroup,
    [PanelType.MoreMenu] = if isInExperienceUIVREnabled then SpatialUIGroupType.MenuUIGroup else SpatialUIGroupType.MainUIGroup
}

if isInExperienceUIVREnabled then
    tbl10 = LuauPolyfill.Object.assign(tbl10, {
        [PanelType.Chat] = SpatialUIGroupType.ChatUIGroup,
        [PanelType.ChromeSubMenu] = SpatialUIGroupType.ChromeSubMenuUIGroup,
        [PanelType.ToolTipsContainer] = SpatialUIGroupType.MainUIGroup
    })
end

local tbl11 = {
    [PanelType.BottomBar] = var7,
    [PanelType.MoreMenu] = var4
}

if isInExperienceUIVREnabled then
    tbl11 = LuauPolyfill.Object.assign(
        tbl11,
        {
            [PanelType.Chat] = var5,
            [PanelType.ChromeSubMenu] = uiGroupElementOffset,
            [PanelType.ToolTipsContainer] = cFrame
        }
    )
end

local function getDragBarOffsetForPanel(bottomBar: string, vector2_6: Vector2?, bool1: boolean?, num6: number?)
    if not vector2_6 then
        local spatialPanelProps = tbl6[bottomBar].spatialPanelProps
        if spatialPanelProps then
            vector2_6 = spatialPanelProps.partSize
        else
            vector2_6 = vector2
        end
    end
    local panelToDragbar = tbl4.PANEL_TO_DRAGBAR
    if num6 then
        panelToDragbar += num6
    end
    local var8 = tbl11[bottomBar]
    if bool1 == true then
        var8 *= CFrame.Angles(0, -math.pi, 0)
    end

    return var8 * CFrame.new(0, -1 * panelDistanceWithSpacing(vector2_6, vector2_5, panelToDragbar).Y, 0)
end

local tbl12 = {
    [SpatialUIGroupType.MainUIGroup] = CFrame.new(0, tbl11[PanelType.BottomBar].Y - 0.075 - 1 / 15, 0)
}

if isInExperienceUIVREnabled then
    local assign = LuauPolyfill.Object.assign
    local tbl13 = {
        [SpatialUIGroupType.MainUIGroup] = getDragBarOffsetForPanel(PanelType.BottomBar, vector2_3, true)
    }
    local chatUiGroup = SpatialUIGroupType.ChatUIGroup
    local Chat2 = PanelType.Chat
    local spatialPanelProps = tbl6[Chat2].spatialPanelProps
    local var8 = if spatialPanelProps then spatialPanelProps.partSize else vector2
    local panelToDragbar = tbl4.PANEL_TO_DRAGBAR

    tbl13[chatUiGroup] = tbl11[Chat2] * CFrame.new(0, -1 * panelDistanceWithSpacing(var8, vector2_5, panelToDragbar).Y, 0)
    local menuUiGroup = SpatialUIGroupType.MenuUIGroup
    local moreMenu = PanelType.MoreMenu
    local spatialPanelProps2 = tbl6[moreMenu].spatialPanelProps
    local var9 = if spatialPanelProps2 then spatialPanelProps2.partSize else vector2
    local panelToDragbar2 = tbl4.PANEL_TO_DRAGBAR

    tbl13[menuUiGroup] = tbl11[moreMenu] * CFrame.new(0, -1 * panelDistanceWithSpacing(var9, vector2_5, panelToDragbar2).Y, 0)
    local chromeSubMenuUiGroup = SpatialUIGroupType.ChromeSubMenuUIGroup
    local chromeSubMenu = PanelType.ChromeSubMenu
    local spatialPanelProps3 = tbl6[chromeSubMenu].spatialPanelProps
    local var10 = if spatialPanelProps3 then spatialPanelProps3.partSize else vector2
    local panelToDragbar3 = tbl4.PANEL_TO_DRAGBAR

    tbl13[chromeSubMenuUiGroup] = tbl11[chromeSubMenu] * CFrame.Angles(0, -math.pi, 0) * CFrame.new(0, -1 * panelDistanceWithSpacing(var10, vector2_5, panelToDragbar3).Y, 0)
    tbl12 = assign(tbl12, tbl13)
end

return {
    SpatialUIType = SpatialUIType,
    SpatialUIGroupType = SpatialUIGroupType,
    PanelType = PanelType,
    DEFAULT_VR_PANEL_SIZE = Vector2.new(10, 10),
    VR_PANEL_RESOLUTION_MULTIPLIER = VR_PANEL_RESOLUTION_MULTIPLIER,
    BOTTOM_BAR_BASE_PART_SIZE = 0.15,
    COMPAT_PANEL_PROPS_MAP = tbl6,
    SPATIAL_PANEL_POSITION_PROPS_MAP = tbl8,
    ROACT_PANEL_UIGROUP_MAP = tbl10,
    ROACT_PANEL_UIGROUP_ELEMENT_OFFSET_MAP = tbl11,
    UIGROUP_DRAGBAR_OFFSET_MAP = tbl12,
    UIGROUP_INITITIAL_ROTATION_MAP = tbl5,
    DRAG_BAR_SIZE = vector2_5,
    BOTTOM_BAR_SIZE = vector2_3,
    SPATIAL_TOOLTIP_SPACING = 2
}
