#= generated by precompiler.jl, do not update manually =#
module Precompilings
using ..BokehJL
using HTTP
using HTTP.Sockets
precompile(Tuple{BokehJL.Model.var"#@wrap", LineNumberNode, Module, Expr})
precompile(Tuple{BokehJL.Model.var"#103#105", Tuple{Int64, Expr}})
precompile(Tuple{BokehJL.Model.var"#102#104"{Module}, Tuple{Int64, Expr}})
precompile(Tuple{BokehJL.Model.var"#106#107"{Symbol}, BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#115#118"{BokehJL.Model._👻Field}, BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#116#119", Symbol})
precompile(Tuple{BokehJL.Model.var"#122#126", BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#112#113"{BokehJL.Model.var"#130#133", Array{BokehJL.Model._👻Field, 1}}, BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#130#133", BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#109#111"{BokehJL.Model._👻Field}, BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#112#113"{BokehJL.Model.var"#128#129"{Symbol}, Array{BokehJL.Model._👻Field, 1}}, BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#128#129"{Symbol}, BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#142#150", BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#112#113"{BokehJL.Model.var"#144#152", Array{BokehJL.Model._👻Field, 1}}, BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#112#113"{typeof(BokehJL.Model._👻defaultvalue), Array{BokehJL.Model._👻Field, 1}}, BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Model.var"#145#153", BokehJL.Model._👻Field})
precompile(Tuple{BokehJL.Server.var"#16#17"{Sockets.TCPServer, Base.Dict{Symbol, BokehJL.Server.iRoute}}, HTTP.Streams.Stream{HTTP.Messages.Request, HTTP.ConnectionPool.Connection}})
precompile(Tuple{BokehJL.Protocol.Messages.var"#ProtocolIterator#7#8", Base.Pairs{Symbol, Union{}, Tuple{}, NamedTuple{(), Tuple{}}}, Type{BokehJL.Protocol.Messages.ProtocolIterator}, Type, NamedTuple{(), Tuple{}}, Base.Pairs{Symbol, Union{}, Tuple{}, NamedTuple{(), Tuple{}}}})
precompile(Tuple{BokehJL.Protocol.Messages.var"##sendmessage#18", Base.Pairs{Symbol, Union{}, Tuple{}, NamedTuple{(), Tuple{}}}, typeof(BokehJL.Protocol.Messages.sendmessage), HTTP.WebSockets.WebSocket, Type{BokehJL.Protocol.Messages.Message{Symbol("PULL-DOC-REPLY")}}, String, Vararg{Any}})
precompile(Tuple{BokehJL.Protocol.Messages.var"#ProtocolIterator#7#8", Base.Pairs{Symbol, String, Tuple{Symbol}, NamedTuple{(:reqid,), Tuple{String}}}, Type{BokehJL.Protocol.Messages.ProtocolIterator}, Type, NamedTuple{(:doc,), Tuple{Base.Dict{Symbol, Any}}}, Base.Pairs{Symbol, Union{}, Tuple{}, NamedTuple{(), Tuple{}}}})
precompile(Tuple{BokehJL.Protocol.var"#9#10"{Base.Dict{Int64, BokehJL.AbstractTypes.iHasProps}}, String})
precompile(Tuple{BokehJL.Events.var"#8#10"{BokehJL.Events.Deferred{BokehJL.Embeddings.Notebooks.NotebooksEventList}}})
precompile(Tuple{BokehJL.Protocol.var"#1#4"{BokehJL.Documents.Document, Base.Set{Int64}, Base.Dict{Int64, BokehJL.AbstractTypes.iHasProps}}, BokehJL.Events.ModelChangedEvent})
precompile(Tuple{BokehJL.Protocol.Messages.var"##sendmessage#17", Base.Pairs{Symbol, Union{}, Tuple{}, NamedTuple{(), Tuple{}}}, typeof(BokehJL.Protocol.Messages.sendmessage), Union{Tuple, Base.AbstractSet{T} where T, AbstractArray{T, 1} where T}, Type{BokehJL.Protocol.Messages.Message{Symbol("PATCH-DOC")}}, NamedTuple{(:events, :references), Tuple{Array{Base.Dict{Symbol, Any}, 1}, Array{Base.Dict{Symbol, Any}, 1}}}, Vararg{Any}})
precompile(Tuple{BokehJL.Protocol.Messages.var"#sendmessage##kw", NamedTuple{(:msgid,), Tuple{String}}, typeof(BokehJL.Protocol.Messages.sendmessage), HTTP.WebSockets.WebSocket, Type{BokehJL.Protocol.Messages.Message{Symbol("PATCH-DOC")}}, NamedTuple{(:events, :references), Tuple{Array{Base.Dict{Symbol, Any}, 1}, Array{Base.Dict{Symbol, Any}, 1}}}, Vararg{Any}})
precompile(Tuple{BokehJL.Protocol.Messages.var"##sendmessage#18", Base.Pairs{Symbol, String, Tuple{Symbol}, NamedTuple{(:msgid,), Tuple{String}}}, typeof(BokehJL.Protocol.Messages.sendmessage), HTTP.WebSockets.WebSocket, Type{BokehJL.Protocol.Messages.Message{Symbol("PATCH-DOC")}}, NamedTuple{(:events, :references), Tuple{Array{Base.Dict{Symbol, Any}, 1}, Array{Base.Dict{Symbol, Any}, 1}}}, Vararg{Any}})
precompile(Tuple{BokehJL.Protocol.Messages.var"#message##kw", NamedTuple{(:msgid,), Tuple{String}}, typeof(BokehJL.Protocol.Messages.message), Type{BokehJL.Protocol.Messages.Message{Symbol("PATCH-DOC")}}, NamedTuple{(:events, :references), Tuple{Array{Base.Dict{Symbol, Any}, 1}, Array{Base.Dict{Symbol, Any}, 1}}}, Array{Pair{String, Array{UInt8, 1}}, 1}})
precompile(Tuple{BokehJL.Protocol.Messages.var"#ProtocolIterator#7#8", Base.Pairs{Symbol, Array{Pair{String, Array{UInt8, 1}}, 1}, Tuple{Symbol}, NamedTuple{(:buffers,), Tuple{Array{Pair{String, Array{UInt8, 1}}, 1}}}}, Type{BokehJL.Protocol.Messages.ProtocolIterator}, Type, NamedTuple{(:events, :references), Tuple{Array{Base.Dict{Symbol, Any}, 1}, Array{Base.Dict{Symbol, Any}, 1}}}, Base.Pairs{Symbol, String, Tuple{Symbol}, NamedTuple{(:msgid,), Tuple{String}}}})
precompile(Tuple{BokehJL.Events.var"##eventlist!#23", Bool, typeof(BokehJL.Events.eventlist!), BokehJL.Protocol.var"#7#8"{BokehJL.Protocol.var"#13#14"{BokehJL.Protocol.Messages.Message{Symbol("PATCH-DOC")}, BokehJL.Documents.Document}, BokehJL.Documents.Document}, BokehJL.Events.NullEventList})
precompile(Tuple{BokehJL.Model.var"#99#101"{BokehJL.Model.EnumType{(:auto, :linear, :log, :datetime, :mercator)}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.FigureOptions, Symbol, BokehJL.Model.EnumType{(:auto, :linear, :log, :datetime, :mercator)}}, Type})
precompile(Tuple{BokehJL.Model.var"#99#101"{BokehJL.Model.EnumType{(:auto,)}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.FigureOptions, Symbol, BokehJL.Model.EnumType{(:auto,)}}, Type})
precompile(Tuple{BokehJL.Model.var"#99#101"{String}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.FigureOptions, Symbol, String}, Type})
precompile(Tuple{BokehJL.Plotting.AxesPlotting.var"#addaxis!##kw", NamedTuple{(:type, :range, :location, :num_minor_ticks, :label, :dotrigger), Tuple{Symbol, Nothing, Symbol, Base.Missing, String, Bool}}, typeof(BokehJL.Plotting.AxesPlotting.addaxis!), BokehJL.Models.Plot, Bool})
precompile(Tuple{BokehJL.Model.var"#96#97", Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.LinearAxis, Symbol, String}, Type})
precompile(Tuple{BokehJL.Plotting.AxesPlotting.var"#addaxis!##kw", NamedTuple{(:location, :dotrigger), Tuple{Symbol, Bool}}, typeof(BokehJL.Plotting.AxesPlotting.addaxis!), BokehJL.Models.Plot, NamedTuple{(:isxaxis, :rangename, :axisname, :range, :scale, :axes, :grids), Tuple{Bool, String, Base.Missing, BokehJL.Models.DataRange1d, BokehJL.Models.LinearScale, Array{BokehJL.Models.iAxis, 1}, Array{BokehJL.Models.Grid, 1}}}})
precompile(Tuple{BokehJL.Model.var"#99#101"{Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.FigureOptions, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#tools!##kw", NamedTuple{(:tooltips, :active_drag, :active_inspect, :active_scroll, :active_tap, :active_multi, :dotrigger), Tuple{Base.Missing, Symbol, Symbol, Symbol, Symbol, Symbol, Bool}}, typeof(BokehJL.Plotting.ToolsPlotting.tools!), BokehJL.Models.Plot, String})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#_arg#8", Base.SubString{String}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#11#13", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.PanTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#10#12", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.PanTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#11#13", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.WheelZoomTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#10#12", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.WheelZoomTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#11#13", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.BoxZoomTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#10#12", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.BoxZoomTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#11#13", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.SaveTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#10#12", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.SaveTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#11#13", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.ResetTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#10#12", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.ResetTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#11#13", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.HelpTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Plotting.ToolsPlotting.var"#10#12", NamedTuple{(:tool, :arg, :keep), Tuple{BokehJL.Models.HelpTool, Symbol, Bool}}})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Toolbar, Symbol, BokehJL.Model.EnumType{(:auto,)}}, Type})
precompile(Tuple{BokehJL.Plotting.GlyphPlotting.var"#18#19"{Base.Dict{String, AbstractArray{T, N} where N where T}}, Symbol, Array{Int64, 1}, BokehJL.Model.Unknown, Type})
precompile(Tuple{BokehJL.Plotting.GlyphPlotting.var"#18#19"{Base.Dict{String, AbstractArray{T, N} where N where T}}, Symbol, Base.UnitRange{Int64}, BokehJL.Model.Unknown, Type})
precompile(Tuple{BokehJL.Plotting.GlyphPlotting.var"#_👻visuals!##kw", NamedTuple{(:trait_color, :prefix, :defaults, :override), Tuple{String, Symbol, Base.Dict{Symbol, Any}, NamedTuple{(:alpha,), Tuple{Float64}}}}, typeof(BokehJL.Plotting.GlyphPlotting._👻visuals!), Base.Dict{Symbol, Any}, Type{BokehJL.Models.Line}})
precompile(Tuple{BokehJL.Plotting.GlyphPlotting.var"#_👻visuals!##kw", NamedTuple{(:trait_color, :prefix, :defaults, :test), Tuple{String, Symbol, Base.Dict{Symbol, Any}, Bool}}, typeof(BokehJL.Plotting.GlyphPlotting._👻visuals!), Base.Dict{Symbol, Any}, Type{BokehJL.Models.Line}})
precompile(Tuple{BokehJL.Model.var"#99#101"{BokehJL.Models.Line}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.GlyphRenderer, Symbol, BokehJL.Models.Line}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.GlyphRenderer, Symbol, BokehJL.Model.EnumType{(:auto,)}}, Type})
precompile(Tuple{BokehJL.Plotting.GlyphPlotting.var"#18#19"{Base.Dict{String, AbstractArray{T, N} where N where T}}, Symbol, Float64, BokehJL.Model.SizeSpec, Type})
precompile(Tuple{BokehJL.Plotting.GlyphPlotting.var"#18#19"{Base.Dict{String, AbstractArray{T, N} where N where T}}, Symbol, Float64, BokehJL.Model.AngleSpec, Type})
precompile(Tuple{BokehJL.Plotting.GlyphPlotting.var"#18#19"{Base.Dict{String, AbstractArray{T, N} where N where T}}, Symbol, Symbol, BokehJL.Model.MarkerSpec, Type})
precompile(Tuple{BokehJL.Plotting.GlyphPlotting.var"#_👻visuals!##kw", NamedTuple{(:trait_color, :prefix, :defaults, :override), Tuple{String, Symbol, Base.Dict{Symbol, Any}, NamedTuple{(:alpha,), Tuple{Float64}}}}, typeof(BokehJL.Plotting.GlyphPlotting._👻visuals!), Base.Dict{Symbol, Any}, Type{BokehJL.Models.Scatter}})
precompile(Tuple{BokehJL.Plotting.GlyphPlotting.var"#_👻visuals!##kw", NamedTuple{(:trait_color, :prefix, :defaults, :test), Tuple{String, Symbol, Base.Dict{Symbol, Any}, Bool}}, typeof(BokehJL.Plotting.GlyphPlotting._👻visuals!), Base.Dict{Symbol, Any}, Type{BokehJL.Models.Scatter}})
precompile(Tuple{BokehJL.Model.var"#99#101"{BokehJL.Models.Scatter}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.GlyphRenderer, Symbol, BokehJL.Models.Scatter}, Type})
precompile(Tuple{BokehJL.Server.var"#10#11"{BokehJL.Server.Application}})
precompile(Tuple{BokehJL.Model.var"#99#101"{BokehJL.Model.EnumType{(:start, :center, :end)}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Plot, Symbol, BokehJL.Model.EnumType{(:start, :center, :end)}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Plot, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#99#101"{BokehJL.Models.Title}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Plot, Symbol, BokehJL.Models.Title}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.LinearScale, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#99#101"{Float64}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.DataRange1d, Symbol, Float64}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.DataRange1d, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#99#101"{Array{BokehJL.AbstractTypes.iModel, 1}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.DataRange1d, Symbol, Array{BokehJL.AbstractTypes.iModel, 1}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Toolbar, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.HelpTool, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.ResetTool, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.SaveTool, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.BoxZoomTool, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.BoxAnnotation, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.WheelZoomTool, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.PanTool, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Title, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.GlyphRenderer, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.CDSView, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.ColumnDataSource, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.UnionRenderers, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Selection, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Scatter, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Line, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.LinearAxis, Symbol, BokehJL.Model.EnumType{(:auto,)}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.LinearAxis, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#99#101"{BokehJL.Model.EnumType{(:horizontal, :vertical)}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.LinearAxis, Symbol, BokehJL.Model.EnumType{(:horizontal, :vertical)}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.BasicTicker, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.AllLabels, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.BasicTickFormatter, Symbol, BokehJL.Model.EnumType{(:auto,)}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.BasicTickFormatter, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Grid, Symbol, BokehJL.Model.EnumType{(:auto,)}}, Type})
precompile(Tuple{BokehJL.Model.var"#98#100"{BokehJL.Models.Grid, Symbol, Nothing}, Type})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.UnionRenderers}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.LinearAxis}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.BasicTickFormatter}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.BoxZoomTool}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.ResetTool}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.Scatter}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.Line}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.BasicTicker}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.SaveTool}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.CDSView}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.GlyphRenderer}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.Plot}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.AllLabels}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.ColumnDataSource}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.Selection}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.DataRange1d}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.PanTool}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.Title}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.LinearScale}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.Grid}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.WheelZoomTool}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.Serialize.var"#2#4"{BokehJL.Models.HelpTool}, Pair{Symbol, Union}})
precompile(Tuple{BokehJL.Protocol.PatchDocReceive.var"#4#7"{String}, Base.Dict{String, Any}})
precompile(Tuple{BokehJL.Protocol.PatchDocReceive.var"#9#10"{DataType}, BokehJL.Models.LinearAxis})
precompile(Tuple{BokehJL.Protocol.PatchDocReceive.var"#9#10"{DataType}, BokehJL.Models.GlyphRenderer})
precompile(Tuple{BokehJL.Protocol.PatchDocReceive.var"#9#10"{DataType}, BokehJL.Models.Grid})
precompile(Tuple{BokehJL.Protocol.PatchDocReceive.var"#9#10"{DataType}, BokehJL.Models.PanTool})
precompile(Tuple{BokehJL.Protocol.PatchDocReceive.var"#9#10"{DataType}, BokehJL.Models.WheelZoomTool})
precompile(Tuple{BokehJL.Protocol.PatchDocReceive.var"#9#10"{DataType}, BokehJL.Models.BoxZoomTool})
precompile(Tuple{BokehJL.Protocol.PatchDocReceive.var"#9#10"{DataType}, BokehJL.Models.SaveTool})
precompile(Tuple{BokehJL.Protocol.PatchDocReceive.var"#9#10"{DataType}, BokehJL.Models.ResetTool})
precompile(Tuple{BokehJL.Protocol.PatchDocReceive.var"#9#10"{DataType}, BokehJL.Models.HelpTool})
end
using .Precompilings