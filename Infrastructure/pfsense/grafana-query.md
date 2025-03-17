## How to query   
    
```
    from(bucket: "pfsense")
      |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
      |> filter(fn: (r) => r["_measurement"] == "net")
      |> filter(fn: (r) => r["host"] =~ /^pfSense\.pfsense\.local$/)
      |> filter(fn: (r) => r["interface"] =~ /^re0$/)
      |> aggregateWindow(every: 1s, fn: mean, createEmpty: false)
      |> pivot(rowKey:["_time"], columnKey: ["_field"], valueColumn: "_value")
      |> group(columns: ["interface"])
      |> derivative(columns: ["bytes_recv","bytes_sent"], nonNegative: true, timeColumn: "_time", unit: 1s)
      |> keep(columns:["_time","bytes_recv","bytes_sent"])
```
    
```yaml
    from(bucket: "${bucket}")
      |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
      |> filter(fn: (r) => r["_measurement"] == "net")
      |> filter(fn: (r) => r["host"] =~ /^${Host:regex}$/)
      |> filter(fn: (r) => r["interface"] =~ /^${LAN_Interfaces:regex}$/)
      |> aggregateWindow(every: $__interval, fn: mean, createEmpty: false)
      |> pivot(rowKey:["_time"], columnKey: ["_field"], valueColumn: "_value")
      |> group(columns: ["interface"])
      |> derivative(columns: ["bytes_recv","bytes_sent"], nonNegative: true, timeColumn: "_time", unit: 1s)
      |> keep(columns:["_time","bytes_recv","bytes_sent"])
```