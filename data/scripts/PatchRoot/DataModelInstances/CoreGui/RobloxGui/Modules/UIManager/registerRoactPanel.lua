-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local UIManager = require(scriptParent.UIManager)
local Constants = require(scriptParent.Constants)

return function(tbl1, panelType)
    local uiGroup = Constants.ROACT_PANEL_UIGROUP_MAP[panelType]
    local cameraFixedPanelProp = uiGroup and {
        uiGroupElementOffset = Constants.ROACT_PANEL_UIGROUP_ELEMENT_OFFSET_MAP[panelType]
    } or nil

    local tbl2 = {
        panelObject = tbl1.current,
        uiType = Constants.SpatialUIType.SpatialUIRoact,
        panelType = panelType,
        headScale = 1,
        panelPositionProps = { uiGroup = uiGroup, cameraFixedPanelProp = cameraFixedPanelProp }
    }
    UIManager.getInstance():registerRoactPanel(panelType, tbl2)
end
