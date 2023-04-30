local json = require("hs.json")

function PrintTable(tbl)
    if tbl == nil then
        print("table is nil")
        return
    end
    local str = json.encode(tbl)
    print(str)
end
