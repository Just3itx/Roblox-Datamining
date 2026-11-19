-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("OpenCloudNotificationScheduledTimeEnabled", false)

local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")
local OpenCloudService = game:GetService("OpenCloudService")
local RunService = game:GetService("RunService")

function returnInvalidArgumentError(message: string)
    return {
        StatusCode = 400,
        Body = HttpService:JSONEncode({ code = "INVALID_ARGUMENT", message = message })
    }
end

function verifyUserNotification(userNotification)
    if userNotification.path ~= nil then
        local var1 = verifyString(userNotification.path)
        if var1 ~= nil then
            return var1
        end
    end

    if userNotification.id ~= nil then
        local var1 = verifyString(userNotification.id)
        if var1 ~= nil then
            return var1
        end
    end

    if userNotification.source ~= nil then
        local var1 = verifySource(userNotification.source)
        if var1 ~= nil then
            return var1
        end
    end

    if userNotification.payload ~= nil then
        local var1 = verifyPayload(userNotification.payload)
        if var1 ~= nil then
            return var1
        end
    end

    return nil
end

function verifySource(source)
    if source.universe ~= nil then
        local var1 = verifyString(source.universe)
        if var1 ~= nil then
            return var1
        end
    end

    return nil
end

function verifyPayload(payload)
    if payload.type ~= nil then
        local var1 = verifyString(payload.type)
        if var1 ~= nil then
            return var1
        end
    end

    if payload.messageId ~= nil then
        local var1 = verifyString(payload.messageId)
        if var1 ~= nil then
            return var1
        end
    end

    if payload.joinExperience ~= nil then
        local var1 = verifyJoinExperience(payload.joinExperience)
        if var1 ~= nil then
            return var1
        end
    end

    if payload.analyticsData ~= nil then
        local var1 = verifyAnalyticsData(payload.analyticsData)
        if var1 ~= nil then
            return var1
        end
    end

    if payload.parameters ~= nil then
        local var1 = verifyParameters(payload.parameters)
        if var1 ~= nil then
            return var1
        end
    end

    if bool1 and payload.scheduleTime ~= nil then
        local var1 = verifyString(payload.scheduleTime)
        if var1 ~= nil then
            return var1
        end
    end

    return nil
end

function verifyJoinExperience(joinExperience)
    if joinExperience.launchData ~= nil then
        local var1 = verifyString(joinExperience.launchData)
        if var1 ~= nil then
            return var1
        end
    end

    return nil
end

function verifyAnalyticsData(analyticsData)
    if analyticsData.category ~= nil then
        local var1 = verifyString(analyticsData.category)
        if var1 ~= nil then
            return var1
        end
    end

    return nil
end

function verifyParameters(parameters)
    for _, parameter in pairs(parameters) do
        local num1 = 0
        if parameter.stringValue ~= nil then
            num1 += 1
            local var1 = verifyString(parameter.stringValue)
            if var1 ~= nil then
                return var1
            end
        end
        if parameter.int64Value ~= nil then
            num1 += 1
            local var1 = verifyNumber(parameter.int64Value)
            if var1 ~= nil then
                return var1
            end
        end
        if num1 > 1 then
            return returnInvalidArgumentError("Too many parameters provided for oneOf object!")
        end
    end

    return nil
end

function verifyNumber(arg1)
    if typeof(arg1) ~= "number" then
        return returnInvalidArgumentError("Argument not a number.")
    end
    return nil
end

function verifyString(arg1)
    if typeof(arg1) ~= "string" then
        return returnInvalidArgumentError("Argument not a string.")
    end
    return nil
end

function getUrlPrefix(): string
    return if RunService:IsStudio() then "user" else "rcc"
end

function createUserNotificationUrl(user: number, _): string
    local str1 = ContentProvider.BaseUrl:lower()
    local var1 = string.gsub(str1, "http:", "https:")
    local var2 = string.gsub(var1, "www", "apis")
    return string.format("%s%s/cloud/v2/users/%d/notifications", var2, getUrlPrefix(), user)
end

function userNotification(arg1)
    if arg1.user ~= nil then
        local var1 = verifyNumber(arg1.user)
        if var1 ~= nil then
            return var1
        end
    end

    if arg1.userNotification ~= nil then
        local var1 = verifyUserNotification(arg1.userNotification)
        if var1 ~= nil then
            return var1
        end
    end

    local body = HttpService:JSONEncode(arg1.userNotification)

    return OpenCloudService:HttpRequestAsync(
        {
            Url = createUserNotificationUrl(arg1.user, arg1.userNotification),
            Request_Type = "POST",
            Body = body
        }
    )
end

OpenCloudService:RegisterOpenCloud("v2", "userNotification", userNotification)
OpenCloudService:RegistrationComplete()
