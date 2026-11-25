-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local VirtualCursorModularParent = script:FindFirstAncestor("VirtualCursorModular").Parent
local SharedFlags = require(VirtualCursorModularParent.SharedFlags)
local FFlagEnableVirtualCursorDebugging = SharedFlags.FFlagEnableVirtualCursorDebugging
local FFlagVirtualCursorMoveAssistIntentRamp = SharedFlags.FFlagVirtualCursorMoveAssistIntentRamp

local Properties = require(scriptParentParent.Properties)

local MoveAssistMinInputMagnitude = Properties.MoveAssistMinInputMagnitude

local var1 = Properties.CursorRadius * 0.5

local function normalizeSafe(vector2: Vector2) -- Luacid: Inlined by compiler; 4 call sites recovered
    local magnitude = vector2.Magnitude
    return if magnitude > 0.00001 then vector2 / magnitude else Vector2.zero
end

local function closestPointOnRect(vector2: Vector2, vector2_2: Vector2, vector2_3: Vector2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local vector22X = vector2_2.X
    local vector22Y = vector2_2.Y
    local var2 = vector2_2.X + vector2_3.X
    local var3 = vector2_2.Y + vector2_3.Y

    return Vector2.new(math.clamp(vector2.X, vector22X, var2), math.clamp(vector2.Y, vector22Y, var3))
end

local function smoothStep(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 * num1 * (3 - num1 * 2)
end

local function computeAimPoint(arg1, vector2: Vector2, cursorRadius: number, num1: number)
    local absoluteSize = arg1.AbsoluteSize
    local absolutePosition = arg1.AbsolutePosition
    local var2 = closestPointOnRect(
        vector2,
        absolutePosition - Vector2.new(cursorRadius, cursorRadius),
        absoluteSize + Vector2.new(num1, num1)
    )
    local var3 = absolutePosition + absoluteSize / 2

    local num2 = math.clamp(1 - math.max(absoluteSize.X, absoluteSize.Y) / num1 / 0.5, 0, 1)

    return var2:Lerp(var3, num2), (closestPointOnRect(vector2, absolutePosition, absoluteSize):Lerp(var3, num2))
end

local function scoreCandidate(arg1, vector2: Vector2, vector2_2: Vector2, cursorRadius: number, num1: number)
    local absoluteSize = arg1.AbsoluteSize
    local var2 = (absoluteSize.X * math.abs(vector2_2.Y) + absoluteSize.Y * math.abs(vector2_2.X)) / num1
    if var2 >= 1 then
        return nil
    end

    local num2 = math.clamp(1 - var2 ^ 2, 0, 1)
    local var3, aimPoint = computeAimPoint(arg1, vector2, cursorRadius, num1)

    local var5 = var3 - vector2
    local magnitude = var5.Magnitude
    local dirToButton = normalizeSafe(var5)
    local dot = vector2_2:Dot(dirToButton)
    local scored = magnitude < Properties.MoveAssistRadius and dot > 0.25
    local var7

    if scored then
        var7 = smoothStep(math.clamp(1 - magnitude / Properties.MoveAssistRadius, 0, 1)) * dot * num2
    else
        var7 = 0
    end

    return {
        scored = scored,
        influence = var7,
        dirToButton = dirToButton,
        distance = magnitude,
        dot = dot,
        aimPoint = aimPoint
    }
end

local function computeAssistStrength(num1: number, num2: number, num3: number, num4: number, bool1: boolean, num5: number, num6: number)
    local confidence = if num1 > 0 then (num1 - num2) / num1 else 0
    local num8 = if bool1 then 0.08 else 0.15
    local confidenceStrength = math.clamp((confidence - num8) / (0.4 - num8), 0, 1)

    local inputFollowStrength = math.clamp((num3 - 0.25) / 0.75, 0, 1)

    local arrivalFactor = math.clamp(num4 / var1, 0, 1)

    return {
        assistStrength = math.clamp(num5 * num6 * confidenceStrength * inputFollowStrength * arrivalFactor, 0, 1),
        confidence = confidence,
        confidenceStrength = confidenceStrength,
        inputFollowStrength = inputFollowStrength,
        arrivalFactor = arrivalFactor
    }
end

local module = {}
module.__index = module

function module.new()
    local self = setmetatable({ _assistTarget = nil, _debugSnapshot = nil }, module)

    if FFlagEnableVirtualCursorDebugging then
        print("[VirtualCursor] MoveAssistController created")
    end

    return self
end

function module:applyMoveAssist(vector2: Vector2, tbl1)
    local cursorPosition = tbl1.cursorPosition
    local candidates = tbl1.candidates
    local masterGain = math.clamp(tbl1.strengthMultiplier, 0, 1)
    local tbl2

    if FFlagEnableVirtualCursorDebugging then
        tbl2 = {}

        self._debugSnapshot = {
            active = false,
            cursorPosition = cursorPosition,
            radius = Properties.MoveAssistRadius,
            inputDir = normalizeSafe(vector2),
            finalDir = normalizeSafe(vector2),
            inputMagnitude = vector2.Magnitude,
            candidates = tbl2,
            committed = nil,
            masterGain = masterGain,
            intentFactor = 0,
            confidence = 0,
            confidenceStrength = 0,
            inputFollowStrength = 0,
            arrivalFactor = 0,
            assistStrength = 0,
            bestInfluence = 0
        }
    else
        tbl2 = nil
    end

    if masterGain <= 0 or not candidates or #candidates == 0 then
        self._assistTarget = nil
        return vector2
    end

    local magnitude = vector2.Magnitude
    if magnitude < 0.00001 then
        self._assistTarget = nil
        return Vector2.zero
    end

    local var2

    if FFlagVirtualCursorMoveAssistIntentRamp then
        var2 = math.clamp((magnitude - MoveAssistMinInputMagnitude) / (0.7 - MoveAssistMinInputMagnitude), 0, 1)
        if var2 <= 0 then
            self._assistTarget = nil
            return vector2
        end
    else
        if magnitude < MoveAssistMinInputMagnitude then
            self._assistTarget = nil
            return vector2
        end

        var2 = 1
    end

    local cursorRadius = Properties.CursorRadius
    local var3 = cursorRadius * 2
    local var4 = vector2 / magnitude

    local num2 = 0
    local num3 = 0
    local zero = Vector2.zero
    local num4 = 0
    local num5 = 0
    local var5 = nil
    local var6 = nil
    for _, value in candidates do
        local tbl3

        if tbl2 then
            tbl3 = {
                position = value.AbsolutePosition,
                size = value.AbsoluteSize,
                influence = 0,
                aimPoint = nil,
                state = "skipped"
            }

            table.insert(tbl2, tbl3)
        else
            tbl3 = nil
        end

        local var7 = scoreCandidate(value, cursorPosition, var4, cursorRadius, var3)
        if not var7 then
            continue
        end

        if tbl3 then
            tbl3.aimPoint = var7.aimPoint
            if var7.scored then
                tbl3.influence = var7.influence
                tbl3.state = "scored"
            end
        end

        if not var7.scored then
            continue
        end

        local influence = var7.influence
        if self._assistTarget ~= nil and value == self._assistTarget then
            influence *= 1.25
        end

        if num2 < influence then
            zero = var7.dirToButton
            num4 = var7.distance
            num5 = var7.dot
            var6 = tbl3
            var5 = value
            num3 = num2
            num2 = influence
        elseif num3 < influence then
            num3 = influence
        end
    end

    if not var5 or num2 < 0.05 then
        self._assistTarget = nil
        return vector2
    end

    local bool1 = if self._assistTarget then var5 == self._assistTarget else false

    if num5 < (if bool1 then 0.25 else 0.5) then
        self._assistTarget = nil
        return vector2
    end

    local tbl3 = computeAssistStrength(num2, num3, num5, num4, bool1, masterGain, var2)

    if tbl3.assistStrength <= 0 then
        self._assistTarget = nil
        return vector2
    end

    self._assistTarget = var5

    local finalDir = normalizeSafe((var4:Lerp(zero, tbl3.assistStrength)))
    if finalDir == Vector2.zero then
        return vector2
    end

    local var8 = finalDir * magnitude
    if FFlagEnableVirtualCursorDebugging then
        if (var8 - vector2).Magnitude > 0 then
            print("Move input adjusted from", vector2, "to", var8)
        end
        local _debugSnapshot = self._debugSnapshot
        if _debugSnapshot then
            _debugSnapshot.active = true
            _debugSnapshot.finalDir = finalDir
            _debugSnapshot.intentFactor = var2
            _debugSnapshot.confidence = tbl3.confidence
            _debugSnapshot.confidenceStrength = tbl3.confidenceStrength
            _debugSnapshot.inputFollowStrength = tbl3.inputFollowStrength
            _debugSnapshot.arrivalFactor = tbl3.arrivalFactor
            _debugSnapshot.assistStrength = tbl3.assistStrength
            _debugSnapshot.bestInfluence = num2
            _debugSnapshot.committed = var5
        end
        if var6 then
            var6.state = "committed"
        end
    end
    return var8
end

function module:clearDebugSnapshot()
    self._debugSnapshot = nil
end

return module
