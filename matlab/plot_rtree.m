function plot_rtree(tree, feature_names)
    G = digraph();
    G = add_node(G, tree, feature_names,'0');

    h = plot(G, 'Layout', 'layered','NodeColor', G.Nodes.Color);
    h.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Split', G.Nodes.Tip);

end

function [G]  = add_node(G, tree, feature_names, node_id)
    if tree.is_leaf
        cell = {node_id,sprintf('%.2f', tree.value),[0 1 0],sprintf('%.2f',tree.value);};
        G = addnode(G, cell2table(cell,'VariableNames',{'Name','Tip','Color','Label'}));
        return
    end
    
    % add a split node
    cell = {node_id,sprintf('%s : %s', feature_names{tree.col_index}, tree.split),[0 0 1],'';};
    G = addnode(G, cell2table(cell,'VariableNames',{'Name','Tip','Color','Label'}));
    
    % add left child
    G = add_node(G, tree.left, feature_names, [node_id '0']);
    
    % add right child
    G = add_node(G, tree.right, feature_names, [node_id '1']);
    
    % add edges
    G = addedge(G, node_id, [node_id '0']);
    G = addedge(G, node_id, [node_id '1']);
end
