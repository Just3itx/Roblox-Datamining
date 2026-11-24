-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)
local RoactNetworking = require(GenericAbuseReportingParent.RoactServiceTags).RoactNetworking
local useRoactService = require(GenericAbuseReportingParent.RobloxAppHooks).useRoactService

local AbuseReportBeduiContext = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiContext)
local AbuseReportBeduiContextStatus = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes).AbuseReportBeduiContextStatus
local AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local fetchBeduiData = require(GenericAbuseReporting.Bedui.Provider.fetchBeduiData)
local validateBeduiData = require(GenericAbuseReporting.Bedui.Provider.validateBeduiData)

local function AbuseReportBeduiProvider(tbl1)
    local value, var2 = React.useState({ status = AbuseReportBeduiContextStatus.Loading })

    local var3 = useRoactService(RoactNetworking)

    React.useEffect(function()
        fetchBeduiData(var3, tbl1.abuseVector):andThen(function(arg1)
            local var4, var5 = validateBeduiData(arg1.responseBody)
            if var4 then
                var2({ status = AbuseReportBeduiContextStatus.Success, beduiData = arg1.responseBody })

                return
            end

            warn("Invalid Bedui data:", var5)

            fetchBeduiData(var3, AbuseVector.Common):andThen(function(arg2)
                local var6, error = validateBeduiData(arg2.responseBody)
                if not var6 then
                    warn("Invalid Bedui common data:", error)
                    var2({ status = AbuseReportBeduiContextStatus.Error, error = error })

                    return
                end
                var2({ status = AbuseReportBeduiContextStatus.Success, beduiData = arg2.responseBody })
            end):catch(function(error)
                warn("Failed to get Bedui common data")
                var2({ status = AbuseReportBeduiContextStatus.Error, error = error })
            end)
        end):catch(function(error)
            warn("Failed to get Bedui data")
            var2({ status = AbuseReportBeduiContextStatus.Error, error = error })
        end)
    end, { tbl1.abuseVector })

    return React.createElement(AbuseReportBeduiContext.Provider, { value = value }, tbl1.children)
end

return AbuseReportBeduiProvider
