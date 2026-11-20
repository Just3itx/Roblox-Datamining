-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
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
    MoreMenu = "MoreMenu"
}

local SpatialUIGroupType = { MainUIGroup = "MainUIGroup", WristUIGroup = "WristUIGroup" }

local partSize = Vector2.new(0.1365, 0.1995) * (10 / 3)

local var1 = Vector2.new(0.532, 0.3395) * (10 / 3)

local cFrame = CFrame.new(var1.X * 0.5 + partSize.X * 0.5 + 1 / 15, (var1.Y - partSize.Y) / 2, 0)

local COMPAT_PANEL_PROPS_MAP = {}
local tbl5 = {
    type = SpatialUIType.SpatialUI,
    spatialPanelProps = {
        name = "ExperienceChat",
        faceCamera = true,
        lerp = true,
        partSize = partSize,
        virtualScreenSize = partSize * 800
    }
}
COMPAT_PANEL_PROPS_MAP[PanelType.Chat] = tbl5

COMPAT_PANEL_PROPS_MAP[PanelType.RobloxGui] = {
    type = SpatialUIType.SpatialUIPartOnly,
    spatialPanelProps = {
        name = "RobloxGuiPanel-PartOnly",
        faceCamera = true,
        lerp = true,
        partSize = var1,
        transparency = 0.5
    }
}

local SPATIAL_PANEL_POSITION_PROPS_MAP = {
    [PanelType.Chat] = {
        uiGroup = SpatialUIGroupType.MainUIGroup,
        cameraFixedPanelProp = { uiGroupElementOffset = cFrame }
    }
}
local tbl7 = {
    uiGroup = SpatialUIGroupType.MainUIGroup,
    cameraFixedPanelProp = {
        uiGroupElementOffset = CFrame.new(0, 0, 0)
    }
}
SPATIAL_PANEL_POSITION_PROPS_MAP[PanelType.RobloxGui] = tbl7

local var3 = CFrame.new(0, -var1.Y * 0.5 - 0.075 - 1 / 30, 0) * CFrame.Angles(0, math.pi, 0)

local var4 = CFrame.new(0.4, -0.36, 0) * CFrame.Angles(0, math.pi, 0)

local ROACT_PANEL_UIGROUP_MAP = {
    [PanelType.BottomBar] = SpatialUIGroupType.MainUIGroup,
    [PanelType.MoreMenu] = SpatialUIGroupType.MainUIGroup
}

local ROACT_PANEL_UIGROUP_ELEMENT_OFFSET_MAP = {
    [PanelType.BottomBar] = var3,
    [PanelType.MoreMenu] = var4
}

return {
    SpatialUIType = SpatialUIType,
    SpatialUIGroupType = SpatialUIGroupType,
    PanelType = PanelType,
    DEFAULT_VR_PANEL_SIZE = Vector2.new(10, 10),
    VR_PANEL_RESOLUTION_MULTIPLIER = 800,
    BOTTOM_BAR_BASE_PART_SIZE = 0.15,
    COMPAT_PANEL_PROPS_MAP = COMPAT_PANEL_PROPS_MAP,
    SPATIAL_PANEL_POSITION_PROPS_MAP = SPATIAL_PANEL_POSITION_PROPS_MAP,
    ROACT_PANEL_UIGROUP_MAP = ROACT_PANEL_UIGROUP_MAP,
    ROACT_PANEL_UIGROUP_ELEMENT_OFFSET_MAP = ROACT_PANEL_UIGROUP_ELEMENT_OFFSET_MAP
}
