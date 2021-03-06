function [D, size_D] = get_dominating_set(G)
%
% function [D, size_D] = get_dominating_set(G)
%
% Greedy algorithm to find dominating set for graph G [1]
% G is a graph structure generated by the GSP toolbox (https://lts2.epfl.ch/gsp/)
% D: indices of vertices in the dominating set
% size_D : cardinality of the dominating set
%
% [1] http://www.inf.usi.ch/faculty/kuhn/teaching/netalg/lectures/chapter7.pdf

% adjacency matrix
B = G.A;

% sort vertices by size of neighborhood
[~,pp] = sort(sum(B>0),'descend');
V = 1:G.N;
V = V(pp);

v = V(1);
D = [v];
ND = find(B(v,:)~=0);
others = setdiff(V(2:end),ND,'stable');

while ~isempty(others)
    v = others(1);
    D = [D;v];
    ND = union( ND,find(B(v,:)~=0) );
    others = setdiff(others,union(ND,D),'stable');
end

size_D = length(D);
