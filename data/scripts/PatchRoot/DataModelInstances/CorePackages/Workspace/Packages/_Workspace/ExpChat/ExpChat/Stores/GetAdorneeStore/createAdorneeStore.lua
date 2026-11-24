-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local createSignal = require(ExpChatParent.Signals).createSignal

local function findFirstChildByNameAndClass(arg1, name: string, str1: string)
    if not arg1 then
        return nil
    end
    for _, child in ipairs(arg1:GetChildren()) do
        if child.Name == name and child:IsA(str1) then
            return child
        end
    end
    return nil
end

local function createAdorneeStore()
    local tbl1 = ({})

    local function getKey(arg1): string -- Luacid: Inlined by compiler; 5 call sites recovered
        return tostring(arg1)
    end

    local function getAdornee(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local key = getKey(arg1)

        if not tbl1[key] then
            local getter, setter = createSignal(nil)
            tbl1[key] = { getter = getter, setter = setter }
        end
        return tbl1[key].getter
    end

    return {
        getAdornee = getAdornee,
        handleAdorneeAdded = function(arg1, arg2, arg3)
            local key = getKey(arg1)

            local firstChildByNameAndClass = findFirstChildByNameAndClass(arg2, "Head", "BasePart")
            if arg3.Health ~= 0 then
                firstChildByNameAndClass = arg2
            end
            if not tbl1[key] then
                getAdornee(arg1)
            end

            tbl1[key].setter(firstChildByNameAndClass)
        end,
        handleHumanoidDied = function(arg1)
            local key = getKey(arg1)

            if tbl1[key] then
                local var1 = tbl1[key].getter(false)
                local var2 = if var1 then findFirstChildByNameAndClass(var1, "Head", "BasePart") or var1 else nil
                tbl1[key].setter(var2)
            end
        end,
        handlePlayerRemoved = function(arg1)
            local key = getKey(arg1)

            if tbl1[key] then
                tbl1[key].setter(nil)
            end

            tbl1[key] = nil
        end
    }
end
return createAdorneeStore
