-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local Signals = require(FriendsChatParent.Signals)
local InExperienceAppChatModal = require(FriendsChatParent.AppChat.InExperienceAppChatModal)
local GetFriendsTabVisibilityStore = require(script.Parent.Parent.GetFriendsTabVisibilityStore)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

return function()
    local var1, var2 = createSignal(0)

    local num1 = 0
    local bool1 = false

    local getUnreadCountToDisplay = createComputed(function(arg1)
        if not GetFriendsTabVisibilityStore(arg1).getIsFriendsTabVisible(arg1) then
            return 0
        end
        return var1(arg1)
    end)

    local function establishBaseline(num2: number) -- Luacid: Inlined by compiler; 1 call site recovered
        bool1 = true
        num1 = num2
        var2(0)
    end

    local function recordCanonicalCount(num2: number)
        if bool1 and GetFriendsTabVisibilityStore(false).getIsFriendsTabVisible(false) then
            local num3 = num2 - num1
            if num3 > 0 then
                var2(var1(false) + num3)
            end
        end
        num1 = num2
    end

    local function clearDisplayCount()
        var2(0)
    end

    local default = InExperienceAppChatModal.default

    if default.hasReceivedInitialUnreadCount then
        establishBaseline(default.unreadCount or 0)
    end

    default.initialUnreadCountSignal.Event:Connect(establishBaseline)
    default.unreadCountSignal.Event:Connect(recordCanonicalCount)

    return {
        getUnreadCountToDisplay = getUnreadCountToDisplay,
        clearDisplayCount = clearDisplayCount
    }
end
