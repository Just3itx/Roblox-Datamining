-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:21:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {
    parseAndCheckHttpResponse = require(script.parseAndCheckHttpResponse).parseAndCheckHttpResponse,
    serializeFetchParameter = require(script.serializeFetchParameter).serializeFetchParameter
}
local selectHttpOptionsAndBody = require(script.selectHttpOptionsAndBody)

tbl1.fallbackHttpConfig = selectHttpOptionsAndBody.fallbackHttpConfig
tbl1.selectHttpOptionsAndBody = selectHttpOptionsAndBody.selectHttpOptionsAndBody

tbl1.checkFetcher = require(script.checkFetcher).checkFetcher
tbl1.createSignalIfSupported = require(script.createSignalIfSupported).createSignalIfSupported
tbl1.selectURI = require(script.selectURI).selectURI
tbl1.createHttpLink = require(script.createHttpLink).createHttpLink
tbl1.HttpLink = require(script.HttpLink).HttpLink

tbl1.rewriteURIForGET = require(script.rewriteURIForGET).rewriteURIForGET

return tbl1
