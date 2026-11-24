-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase
local FFlagBuildExperienceModelPickerData = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceModelPickerData
local _model = require(script.Parent.Parent.Types.model)

local ACP_PATH = game:DefineFastString("MyStatsExperienceStatsPath", "/my-stats-service/v1")

return {
    acpUrl = function()
        return UrlBase.APIS .. ACP_PATH
    end,
    ACP_PATH = ACP_PATH,
    ProtocolVersion = 2,
    Methods = {
        Initialize = "initialize",
        SessionNew = "session/new",
        SessionList = "session/list",
        SessionLoad = "session/load",
        SessionPrompt = "session/prompt",
        SessionCancel = "session/cancel",
        SessionFindByUniverse = "_roblox/session/find_by_universe",
        SessionDelete = "_roblox/session/delete",
        SessionUpdateInfo = "_roblox/session/update_info",
        SessionReadTasks = "_roblox/session/read_tasks",
        SessionSaveAndPublish = "_roblox/session/save_and_publish",
        AdCampaignEligibility = "_roblox/ad_campaign/eligibility",
        AdCampaignCheckFunds = "_roblox/ad_campaign/check_funds",
        AdCampaignCreate = "_roblox/ad_campaign/create",
        AdCampaignToolCallStatus = "_roblox/ad_campaign/tool_call_status"
    },
    Notifications = { SessionUpdate = "session/update" },
    ErrorCodes = {
        ParseError = -32700,
        InvalidRequest = -32600,
        MethodNotFound = -32601,
        InvalidParams = -32602,
        InternalError = -32603,
        Unauthorized = -32000,
        Forbidden = -32001,
        NotFound = -32002,
        Conflict = -32003,
        UpstreamUnavailable = -32004,
        Gone = -32005,
        OutOfCredits = -32006,
        PayloadTooLarge = -32007,
        InsufficientFunds = -32008,
        MissingThumbnail = -32009
    },
    AskTool = { Name = "ask_tool" },
    CapRtnNamespace = "AssistantPlugin",
    extractSessionNewProject = function(arg1)
        if typeof(arg1) ~= "table" then
            return nil
        end
        local _roblox = arg1._meta and arg1._meta._roblox
        return if typeof(_roblox) == "table" and typeof(_roblox.universeId) == "number" and typeof(_roblox.placeId) == "number" then _roblox else nil
    end,
    buildSessionNewWireParams = function(tbl1)
        local _roblox = {
            universeId = tbl1.project.universeId,
            placeId = tbl1.project.placeId
        }
        if tbl1.experiment ~= nil then
            _roblox.experiment = tbl1.experiment
        end
        if FFlagBuildExperienceModelPickerData and tbl1.model ~= nil then
            _roblox.model = tbl1.model
        end
        if tbl1.application ~= nil then
            _roblox.application = tbl1.application
        end
        if tbl1.chatOpenId ~= nil then
            _roblox.chatOpenId = tbl1.chatOpenId
        end
        return {
            cwd = tbl1.cwd,
            mcpServers = tbl1.mcpServers,
            _meta = { _roblox = _roblox }
        }
    end,
    buildSessionPromptWireParams = function(tbl1)
        local tbl2 = {
            sessionId = tbl1.sessionId,
            prompt = tbl1.prompt
        }
        if FFlagBuildExperienceModelPickerData and (tbl1.model ~= nil or tbl1.experiment ~= nil) then
            local _meta = tbl1.meta == nil and {} or table.clone(tbl1.meta)
            local _roblox = _meta._roblox == nil and {} or table.clone(_meta._roblox)
            if tbl1.model ~= nil then
                _roblox.model = tbl1.model
            end
            if tbl1.experiment ~= nil then
                _roblox.experiment = tbl1.experiment
            end
            _meta._roblox = _roblox
            tbl2._meta = _meta
            return tbl2
        end
        if tbl1.experiment == nil then
            if tbl1.meta ~= nil then
                tbl2._meta = tbl1.meta
            end
            return tbl2
        end

        local _roblox = {}
        if tbl1.meta ~= nil and tbl1.meta._roblox ~= nil then
            for value, value2 in tbl1.meta._roblox do
                _roblox[value] = value2
            end
        end
        _roblox.experiment = tbl1.experiment
        tbl2._meta = { _roblox = _roblox }
        return tbl2
    end
}
