#- file generated by BokehServer's 'CodeCreator': edit at your own risk! -#

@model mutable struct ColumnDataSource <: iColumnDataSource

    data :: Model.DataDict = Model.DataDict()

    selected :: Model.ReadOnly{iSelection} = Selection()

    selection_policy :: iSelectionPolicy = UnionRenderers()
end
export ColumnDataSource
