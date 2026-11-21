-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, str1: string, videoTitle, videoId, universeId: string?, interactionType: string?)
    assert(type(str1) == "string", "Expected eventContext to be a string")

    arg1:setRBXEventStream(
        str1,
        "openYouTubeVideo",
        {
            videoTitle = videoTitle,
            videoID = videoId,
            universeId = universeId,
            interactionType = interactionType
        }
    )
end
