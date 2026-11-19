-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ErrorReport = require(script.Parent.ErrorReport)
local _ErrorReportersParent = script:FindFirstAncestor("ErrorReporters").Parent

local module = {}

local bool1 = game:DefineFastFlag("SentryIncludeRolloutFlagsContext", false)

local bool2 = game:DefineFastFlag("SentryIncludeIxpEnrolledExperimentsContext", false)

local function isJsonCompatible(arg1): boolean -- Luacid: unused: defined but never referenced
    local str1 = typeof(arg1)

    if arg1 == nil or str1 == "string" or str1 == "boolean" then
        return true
    end

    if str1 ~= "number" then
        return false
    end

    return arg1 == arg1 and arg1 ~= math.huge and arg1 ~= -math.huge
end

function module.safeGet(attributes, str1: string)
    local success, result = pcall(function()
        return attributes[str1]
    end)

    if not success then
        return "unparsable"
    end

    local str2 = typeof(result)

    return if result == nil
        or str2 == "string"
        or str2 == "boolean"
        or str2 == "number" and result == result and result ~= math.huge and result ~= -math.huge then result else "json_incompatible"
end

local function toUnsignedInt(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    if arg1 == nil then
        return nil
    end

    local var1 = tonumber(arg1)
    if var1 == nil then
        return nil
    elseif var1 < 0 then
        return 0
    end

    return math.floor(var1)
end

local function convertErrorStackToSentryFrame(arg1)
    local tbl1 = {
        lineno = tonumber(arg1.line) or 0
    }

    if arg1.funcName then
        tbl1["function"] = arg1.funcName
    end

    if arg1.sourceCode then
        tbl1.filename = arg1.sourceCode
        tbl1.abs_path = arg1.sourceCode
    end

    if arg1.column then
        tbl1.colno = tonumber(arg1.column)
    end

    if arg1.library then
        tbl1.module = arg1.library
    end

    if arg1.address then
        tbl1.instruction_addr = arg1.address
    end

    if arg1.guessed_frame == false then
        tbl1.in_app = true
    end

    return tbl1
end

function module.parseThreadsToSentry(arg1)
    if not arg1 then
        return nil
    end

    local values = {}
    local num1 = 1

    for k, value in pairs(arg1) do
        local tbl2 = {
            id = num1,
            name = value.name or k
        }

        if k == "main" or value.name == "main" then
            tbl2.main = true
        end

        if value.fault == true then
            tbl2.crashed = true
        end

        if value.stack and #value.stack > 0 then
            local tbl3 = {}

            for _, value2 in ipairs(value.stack) do
                table.insert(tbl3, (convertErrorStackToSentryFrame(value2)))
            end

            local frames = {}
            for i = #tbl3, 1, -1 do
                table.insert(frames, tbl3[i])
            end

            tbl2.stacktrace = { frames = frames }
        end

        table.insert(values, tbl2)
        num1 += 1
    end

    return if #values == 0 then nil else { values = values }
end

local function parseAppContext(arg1)
    local result = ({})
    local attributes = arg1.attributes

    local appVersion = module.safeGet(attributes, "appVersion")
    if appVersion ~= nil then
        result.app_version = appVersion
    end

    local deviceAppHash = module.safeGet(attributes, "AppInstallationId")
    if deviceAppHash ~= nil then
        result.device_app_hash = deviceAppHash
    end

    local coreScriptVersion = module.safeGet(attributes, "CoreScriptVersion")
    if coreScriptVersion ~= nil then
        result.core_script_version = coreScriptVersion
    end

    local robloxChannel = module.safeGet(attributes, "RobloxChannel")
    if robloxChannel ~= nil then
        result.roblox_channel = robloxChannel
    end

    local appRunningTime = module.safeGet(attributes, "AppRunningTime")
    if appRunningTime ~= nil then
        result.app_running_time = appRunningTime
    end

    local userAgent = module.safeGet(attributes, "UserAgent")
    if userAgent ~= nil then
        result.user_agent = userAgent
    end

    local baseUrl = module.safeGet(attributes, "BaseUrl")
    if baseUrl ~= nil then
        result.base_url = baseUrl
    end

    local windowsLaunchType = module.safeGet(attributes, "WindowsLaunchType")
    if windowsLaunchType ~= nil then
        result.windows_launch_type = windowsLaunchType
    end

    local countryCode = module.safeGet(attributes, "CountryCode")
    if countryCode ~= nil then
        result.country_code = countryCode
    end

    if bool1 then
        local rolloutFlagsInControl = module.safeGet(attributes, "RolloutFlagsInControl")
        if rolloutFlagsInControl ~= nil then
            result.rollout_flags_in_control = rolloutFlagsInControl
        end

        local rolloutFlagsInVariant = module.safeGet(attributes, "RolloutFlagsInVariant")
        if rolloutFlagsInVariant ~= nil then
            result.rollout_flags_in_variant = rolloutFlagsInVariant
        end
    end

    if bool2 then
        local ixpEnrolledExperiments = module.safeGet(attributes, "IxpEnrolledExperiments")
        if ixpEnrolledExperiments ~= nil then
            result.ixp_enrolled_experiments = ixpEnrolledExperiments
        end
    end

    return result
end

local function parseNetworkContext(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = ({})

    local networkType = module.safeGet(arg1.attributes, "networkType")
    if networkType ~= nil then
        result.network_type = networkType
    end

    return result
end

local function parseOSContext(arg1)
    local result = ({})
    local attributes = arg1.attributes

    local name = module.safeGet(attributes, "baseOs")
    if name ~= nil then
        result.name = name
    end

    local version = module.safeGet(attributes, "systemVersion")
    if version ~= nil then
        result.version = version
    end

    return result
end

local function parseDeviceContext(arg1)
    local result = ({})
    local attributes = arg1.attributes

    local name = module.safeGet(attributes, "deviceName")
    if name ~= nil then
        result.name = name
    end

    local var2 = module.safeGet(attributes, "batteryLevel")
    if var2 ~= nil then
        local batteryLevel = tonumber(var2)
        if batteryLevel ~= nil then
            result.battery_level = batteryLevel
        end
    end

    local manufacturer = module.safeGet(attributes, "manufacturer")
    if manufacturer ~= nil then
        result.manufacturer = manufacturer
    end

    local var4 = module.safeGet(attributes, "maxMemory")
    if var4 ~= nil then
        local memorySize = toUnsignedInt(var4)

        if memorySize ~= nil then
            result.memory_size = memorySize
        end
    end

    local var5 = module.safeGet(attributes, "availRAM")
    if var5 ~= nil then
        local freeMemory = toUnsignedInt(var5)

        if freeMemory ~= nil then
            result.free_memory = freeMemory
        end
    end

    local screenResolution = module.safeGet(attributes, "maxResolution")
    if screenResolution ~= nil then
        result.screen_resolution = screenResolution
    end

    local thermalStatus = module.safeGet(attributes, "thermalStatus")
    if thermalStatus ~= nil then
        result.thermal_status = thermalStatus
    end

    local var8 = module.safeGet(attributes, "cpuLogicalCount")
    if var8 ~= nil then
        local processorCount = toUnsignedInt(var8)

        if processorCount ~= nil then
            result.processor_count = processorCount
        end
    end

    local var9 = module.safeGet(attributes, "cpuCoreCount")
    if var9 ~= nil then
        local cpuCoreCount = toUnsignedInt(var9)

        if cpuCoreCount ~= nil then
            result.cpu_core_count = cpuCoreCount
        end
    end

    local cpuDescription = module.safeGet(attributes, "cpuMake")
    if cpuDescription ~= nil then
        result.cpu_description = cpuDescription
    end

    local var11 = module.safeGet(attributes, "cpuPhysCount")
    if var11 ~= nil then
        local cpuPhysicalCount = toUnsignedInt(var11)

        if cpuPhysicalCount ~= nil then
            result.cpu_physical_count = cpuPhysicalCount
        end
    end

    local var12 = module.safeGet(attributes, "cpuSpeed")
    if var12 ~= nil then
        local cpuSpeed = toUnsignedInt(var12)

        if cpuSpeed ~= nil then
            result.cpu_speed = cpuSpeed
        end
    end

    return result
end

local function parseCustomMetadataContexts(arg1)
    local result = ({})
    local customMetadata = arg1.customMetadata

    if type(customMetadata) ~= "table" then
        return result
    end

    for value, value2 in customMetadata do
        if type(value2) == "table" and next(value2) ~= nil then
            result[value] = value2
        end
    end

    return result
end

function module.parseErrorToContext(arg1)
    local result = ({})

    result.app = parseAppContext(arg1)
    result.network = parseNetworkContext(arg1)
    result.os = parseOSContext(arg1)
    result.device = parseDeviceContext(arg1)

    for value, value2 in parseCustomMetadataContexts(arg1) do
        result[value] = value2
    end

    return result
end

return module
