-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReportingParent = script:FindFirstAncestor("ChatLineReporting").Parent
local FFlagExpChatPresetChatEnabled = require(ChatLineReportingParent.ExpChatShared).Flags.FFlagExpChatPresetChatEnabled
local FFlagEnableChatReportingTextChannelTag = require(ChatLineReportingParent.SharedFlags).FFlagEnableChatReportingTextChannelTag

local bool1 = game:DefineFastFlag("ChangePresetTagName", false)

local tbl1 = {
    Variant = { CLRv1 = "CLRv1" }
}

function buildReport(num1: number, str1: string, str2: string, str3: string, str4: string?, str5: string?, str6: string?, str7: string?)
    local tbl2 = {
        tags = {
            ENTRY_POINT = {
                valueList = {{ data = "in-experience" }}
            },
            SUBMITTER_USER_ID = {
                valueList = {{
                    data = tostring(num1)
                }}
            },
            REPORTED_ABUSE_CATEGORY = {
                valueList = {{ data = str2 }}
            },
            REPORTER_COMMENT = {
                valueList = {{ data = str3 }}
            },
            REPORTED_ABUSE_VECTOR = {
                valueList = {{ data = "chat" }}
            },
            REPORT_TARGET_USER_ID = {
                valueList = {{ data = str1 }}
            },
            VARIANT = {
                valueList = {{
                    data = tbl1.Variant.CLRv1
                }}
            }
        }
    }

    if str4 then
        tbl2.tags.REPORT_TARGET_MESSAGE_ID = {
            valueList = {{ data = str4 }}
        }
    end

    if FFlagExpChatPresetChatEnabled and str5 and str5 ~= "" then
        if bool1 then
            tbl2.tags.PRESET_ID = {
                valueList = {{ data = str5 }}
            }
        else
            tbl2.tags.REPORT_TARGET_PRESET_ID = {
                valueList = {{ data = str5 }}
            }
        end

        if str6 and str6 ~= "" then
            if bool1 then
                tbl2.tags.PRESET_CHAT_VERSION = {
                    valueList = {{ data = str6 }}
                }
            else
                tbl2.tags.REPORT_TARGET_PRESET_VERSION = {
                    valueList = {{ data = str6 }}
                }
            end
        end
    end

    if FFlagEnableChatReportingTextChannelTag then
        tbl2.tags.IN_GAME_CHAT_TEXT_CHANNEL = {
            valueList = {{
                data = str7 or "RBXGlobal"
            }}
        }
    end

    return tbl2
end

return buildReport
