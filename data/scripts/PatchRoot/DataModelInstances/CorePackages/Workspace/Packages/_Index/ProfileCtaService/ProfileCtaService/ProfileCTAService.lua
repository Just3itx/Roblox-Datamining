-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileCtaServiceParent = script:FindFirstAncestor("ProfileCtaService").Parent

local ProfileCTAStore = require(ProfileCtaServiceParent.DataHydration).Profile.ProfileCTAStore

local createProfileCTAEventListener = require(script.Parent.createProfileCTAEventListener)

local function createProfileCTAService()
    local num1 = 0
    local tbl1 = ({})
    local var1 = ProfileCTAStore.get()

    local function refetchCTA(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        var1.getCTA(str1, true)
    end

    createProfileCTAEventListener(function(str1: string) -- name: handleCTAUpdate
        if num1 > 0 then
            refetchCTA(str1)
            return
        end

        tbl1[str1] = true
    end)
    local function enableRealTimeUpdates() -- Luacid: Inlined by compiler; 1 call site recovered
        num1 += 1
    end

    local function disableRealTimeUpdates() -- Luacid: Inlined by compiler; 1 call site recovered
        num1 -= 1

        if num1 < 0 then
            error(
                "ProfileCTAService: disableRealTimeUpdates called more times than enableRealTimeUpdates. consumerConnectionCount: " .. tostring(num1)
            )
        end
    end

    return {
        connectRealTimeUpdates = function()
            enableRealTimeUpdates()
            local bool1 = false

            return {
                Disconnect = function()
                    if bool1 then
                        return
                    end
                    bool1 = true
                    disableRealTimeUpdates()
                end
            }
        end,
        getProfileCTA = function(str1: string)
            local bool1

            if tbl1[str1] then
                tbl1[str1] = nil
                bool1 = true
            else
                bool1 = false
            end
            return var1.getCTA(str1, bool1)
        end,
        getProfileCTAs = function(tbl2)
            local tbl3 = ({})
            for _, value in ipairs(tbl2) do
                if tbl1[value] then
                    tbl3[value] = true
                    tbl1[value] = nil
                else
                    tbl3[value] = false
                end
            end
            return var1.getBatchCTAs(tbl2, tbl3)
        end
    }
end

return (createProfileCTAService())
