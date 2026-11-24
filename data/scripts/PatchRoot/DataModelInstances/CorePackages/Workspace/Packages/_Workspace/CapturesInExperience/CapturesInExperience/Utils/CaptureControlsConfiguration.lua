-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Cryo = require(scriptParentParentParent.Cryo)
local getDeepValue = require(scriptParentParentParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue
local getLocalUserId = require(scriptParentParent.Utils.getLocalUserId)

local Constants = require(scriptParentParent.Constants)

local engineFeature = game:GetEngineFeature("CaptureControlsAppStorageEnabled")

local vector2 = Vector2.new(1, 0.5)

local module = {}
local tbl1 = {}

local str1 = tostring(game.GameId)
local localUserId = getLocalUserId(Players)

local num1 = game:DefineFastInt("CaptureControlsStoredAnchorPoints", 100)

function module.getStoredSnapAnchorPoint()
    if not (engineFeature and localUserId) then
        return vector2
    end

    local success, result = pcall(function(): string
        return AppStorageService:GetItem(Constants.CaptureControlsPositionStorageKey)
    end)

    if not success then
        return vector2
    end

    local success2, result2 = pcall(function()
        return HttpService:JSONDecode(result)
    end)

    if not success2 then
        return vector2
    end

    tbl1 = result2

    local deepValue = getDeepValue(result2, string.format("%s.%s", localUserId, str1))

    if not deepValue then
        return vector2
    end

    return Vector2.new(deepValue.X, deepValue.Y)
end

function module.setStoredSnapAnchorPoint(vector2_2: Vector2)
    if not (engineFeature and localUserId) then
        return
    end

    local tbl2 = {
        X = vector2_2.X,
        Y = vector2_2.Y,
        timestamp = os.time()
    }

    local var1 = tbl1[localUserId] or {}

    var1[str1] = tbl2

    local var2 = Cryo.Dictionary.keys(var1)
    if #var2 > num1 then
        local var3 = Cryo.List.sort(var2, function(arg1, arg2): boolean
            return var1[arg1].timestamp > var1[arg2].timestamp
        end)

        local var4 = Cryo.List.toSet(Cryo.List.removeRange(var3, num1 + 1, #var3))

        var1 = Cryo.Dictionary.filter(var1, function(_, arg1)
            return var4[arg1]
        end)
    end
    local input = Cryo.Dictionary.union(tbl1, { [localUserId] = var1 })

    AppStorageService:SetItem(Constants.CaptureControlsPositionStorageKey, HttpService:JSONEncode(input))
    tbl1 = input
end

return module
