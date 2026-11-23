-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local ProfileCtaService = require(UserListParent.ProfileCtaService)
local Enums = require(UserList.Common.Enums)
local _Types = require(UserList.Common.Types)

local CtaRow = require(UserList.Cta.CtaRow)
local SurfaceJoinCtaRow = require(UserList.Cta.SurfaceJoinCtaRow)
local useCtaActionHandlers = require(script.Parent.useCtaActionHandlers)
local Constants = require(UserList.Common.Constants)
local FFlagUserListCanonicalCtaAnalytics = require(UserList.Flags.FFlagUserListCanonicalCtaAnalytics)
local FFlagUserListDefaultCtaWidths = require(UserListParent.SharedFlags).FFlagUserListDefaultCtaWidths
local FFlagUserListSurfaceExtensions = require(UserListParent.SharedFlags).FFlagUserListSurfaceExtensions

local ProfileCTAService = ProfileCtaService.ProfileCTAService

local tbl1 = {}

local function useCtaRenderRow(arg1, renderRow)
    React.useEffect(function()
        local var1 = ProfileCTAService.connectRealTimeUpdates()
        return function()
            var1.Disconnect()
        end
    end, {})

    local actionHandlers = useCtaActionHandlers(arg1)

    local ctaConfig = React.useMemo(function()
        if not FFlagUserListDefaultCtaWidths or not arg1 or arg1.primaryCtaMinWidth ~= nil and arg1.primaryCtaMaxWidth ~= nil then
            return arg1
        end

        local var2 = table.clone(arg1)
        var2.primaryCtaMinWidth = arg1.primaryCtaMinWidth or Constants.DEFAULT_PRIMARY_CTA_MIN_WIDTH
        var2.primaryCtaMaxWidth = arg1.primaryCtaMaxWidth or Constants.DEFAULT_PRIMARY_CTA_MAX_WIDTH
        return var2
    end, { arg1 })

    return React.useMemo(function()
        local var3 = if FFlagUserListSurfaceExtensions and ctaConfig and ctaConfig.join then SurfaceJoinCtaRow else CtaRow

        return function(createRow, entity, index: number)
            if entity.type ~= Enums.EntityType.User then
                if renderRow then
                    return renderRow(createRow, entity, index)
                end
                return createRow(tbl1)
            end
            local createElement = React.createElement
            local var4 = var3
            local tbl2 = {
                createRow = createRow,
                entity = entity,
                actionHandlers = actionHandlers,
                ctaConfig = ctaConfig,
                index = 0,
                renderRow = 0
            }

            if not (FFlagUserListCanonicalCtaAnalytics or renderRow) then
                index = nil
            end

            tbl2.index = index
            tbl2.renderRow = renderRow
            return createElement(var4, tbl2)
        end
    end, { actionHandlers, ctaConfig, renderRow })
end

return useCtaRenderRow
