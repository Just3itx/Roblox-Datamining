-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)
local Cryo = require(MomentsParent.Cryo)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local function createUsersStore()
    local getUsersByUserId, var2 = createSignal({})

    local tbl1 = ({})
    local tbl2 = {}

    return {
        getUsersByUserId = getUsersByUserId,
        getUserProfile = function(str1: string)
            if tbl1[str1] == nil then
                tbl1[str1] = createComputed(function(arg1)
                    return getUsersByUserId(arg1)[str1] or tbl2
                end)
            end
            return tbl1[str1]
        end,
        updateUsername = function(num1: number, username: string)
            local str1 = tostring(num1)
            local var3 = getUsersByUserId(false)
            local var4 = var3[str1] or {}
            var2((Cryo.Dictionary.union(var3, { [str1] = Cryo.Dictionary.union(var4, { username = username }) })))
        end,
        updateAvatar = function(num1: number, avatarThumbnailUri: string)
            local str1 = tostring(num1)
            local var3 = getUsersByUserId(false)
            local var4 = var3[str1] or {}
            var2(
                (Cryo.Dictionary.union(var3, { [str1] = Cryo.Dictionary.union(var4, { avatarThumbnailUri = avatarThumbnailUri }) }))
            )
        end,
        updateMomentsCount = function(num1: number, momentsCount: number)
            local str1 = tostring(num1)
            local var3 = getUsersByUserId(false)
            local var4 = var3[str1] or {}
            var2((Cryo.Dictionary.union(var3, { [str1] = Cryo.Dictionary.union(var4, { momentsCount = momentsCount }) })))
        end,
        invalidateMomentsCount = function(num1: number)
            local str1 = tostring(num1)
            local var3 = getUsersByUserId(false)
            local var4 = var3[str1]
            if not var4 then
                return
            end
            var2((Cryo.Dictionary.union(var3, { [str1] = Cryo.Dictionary.join(var4, { momentsCount = Cryo.None }) })))
        end,
        updateUserInfo = function(num1: number, displayName: string, hasVerifiedBadge: boolean)
            local str1 = tostring(num1)
            local var3 = getUsersByUserId(false)
            local var4 = var3[str1] or {}
            var2(
                (Cryo.Dictionary.union(
                    var3,
                    {
                        [str1] = Cryo.Dictionary.union(var4, { displayName = displayName, hasVerifiedBadge = hasVerifiedBadge })
                    }
                ))
            )
        end
    }
end

return createUsersStore
