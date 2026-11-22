-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    { pattern = "failed with status 429", status = "UploadQuotaReached" },
    { pattern = "failed with status -1", status = "NetworkError" },
    { pattern = "failed with status 0", status = "NetworkError" },
    { pattern = "S3 upload failed for chunk", status = "NetworkError" },
    { pattern = "failed with status 5", status = "ServerError" },
    { pattern = "failed with status 4", status = "InvalidRequest" },
    { pattern = "failed to parse response", status = "ServerError" },
    { pattern = "S3 response missing ETag", status = "ServerError" },
    { pattern = "S3 chunk range exceeds", status = "InvalidRequest" },
    { pattern = "CreatePostParams", status = "InvalidRequest" },
    { pattern = "CreatePostAsync:", status = "InvalidRequest" },
    { pattern = "not uploadable", status = "InvalidRequest" },
    { pattern = "Capture data is empty", status = "InvalidRequest" },
    { pattern = "Invalid capture", status = "InvalidRequest" },
    { pattern = "multi-media posts are not yet supported", status = "InvalidRequest" },
    { pattern = "is not enabled", status = "InvalidRequest" }
}

local function classifyPostUploadError(arg1)
    local str1 = tostring(arg1)
    for _, value in tbl1 do
        if string.find(str1, value.pattern, 1, true) then
            return value.status
        end
    end
    return "GenericFailure"
end

return classifyPostUploadError
