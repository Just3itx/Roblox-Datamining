-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local AppStorageService = game:GetService("AppStorageService")

local RoduxSquads = require(SquadsCore.RoduxSquads)
local Constants = require(SquadsCore.Common.Constants)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local fetchActiveSquad = require(SquadsCore.Thunks.fetchActiveSquad)
local useCurrentSquadId = require(SquadsCore.Hooks.useCurrentSquadId)
local validateSquadId = require(SquadsCore.Common.validateSquadId)

local React = require(SquadsCoreParent.React)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect

return function()
    local var1 = useDispatch()
    local var2 = useCurrentSquadId() or ""
    local var3, var4 = React.useState(false)

    local var5 = React.useContext(SquadExternalContractContext).useIsChatEnabled()

    React.useEffect(function()
        if var3 then
            AppStorageService:SetItem(Constants.ACTIVE_SQUAD_APP_STORAGE_KEY, var2)
            AppStorageService:Flush()
        end
    end, { var2, var3 })

    useEffect(function()
        if not var5 then
            return
        end

        local item = AppStorageService:GetItem(Constants.ACTIVE_SQUAD_APP_STORAGE_KEY)
        local var6 = validateSquadId(item)
        if var6 and var2 == "" then
            var1(fetchActiveSquad())
        elseif item ~= "" and not var6 or var2 ~= "" and var2 ~= item then
            var1(RoduxSquads.Actions.CurrentSquadUpdated(nil))
            AppStorageService:SetItem(Constants.ACTIVE_SQUAD_APP_STORAGE_KEY, "")
            AppStorageService:Flush()
        end

        var4(true)
    end, { var5 })

    return nil
end
