-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:21:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local MemStorageService = game:GetService("MemStorageService")
local HttpService = game:GetService("HttpService")

return function(tbl1)
    local module = {
        persist = function(_, input): boolean
            local success, _result = pcall(function()
                MemStorageService:SetItem(tbl1.storeKey, HttpService:JSONEncode(input))
            end)
            if not success then
                print("PersistenceMiddleware - failed to update the store", tbl1.storeKey)
            end
            return success
        end,
        restore = function()
            local success, result = pcall(function()
                local item = MemStorageService:GetItem(tbl1.storeKey)
                if item and item ~= "" then
                    return HttpService:JSONDecode(item)
                end
                return nil
            end)
            return if success then result else nil
        end,
        clean = function(): boolean
            local success, _result = pcall(function()
                MemStorageService:SetItem(tbl1.storeKey, "")
            end)
            if not success then
                print("PersistenceMiddleware - failed to clean the store", tbl1.storeKey)
            end
            return success
        end
    }

    function module.getMiddleware(_)
        return function(arg1, arg2)
            arg2.changed:connect(function(arg3, _)
                module.persist(arg2, arg3)
            end)
            return function(arg3)
                return arg1(arg3)
            end
        end
    end

    return module
end
