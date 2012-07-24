#!/usr/bin/env ruby

class Tree
	attr_accessor :children, :node_name
	def initialize(hash)
		@node_name = hash.keys[0]
		@children = hash[@node_name]
	end

	def visit_all_dfs(&block)
		visit &block
		children.each do |node, subnode|
			if (subnode)
				t = Tree.new({node =>subnode})
				t.visit_all_dfs &block
			end
		end
	end

	def visit_all_bfs(&block)
		visit &block
		_visit_all_bfs &block
	end

	def _visit_all_bfs(&block)
		next_nodes_to_visit = []
		children.each do |node, subnode|
			tree = Tree.new({node=>subnode})
			tree.visit &block
			next_nodes_to_visit.push(tree)
		end
		next_nodes_to_visit.each do |tree|
			tree._visit_all_bfs &block
		end
	end

	def visit(&block)
		block.call self
	end
end

ruby_tree = Tree.new({'grandpa' => {
			 'dad' => { 'child 1' => {}, 'child 2' =>{}},
			 'uncle' => {'child 3'=> {}, 'child 4' => {}},
			 'aunt' => {'child 5'=> {}, 'child 6' => {}, 'child 7' => {}}
			  }
			})

#puts "Visiting a node"
#ruby_tree.visit {|node| puts node.node_name}

puts
puts "Visiting entire tree:"
puts "Deep First Search"
ruby_tree.visit_all_dfs {|node| puts node.node_name}
puts
puts "Breadth First Search"
ruby_tree.visit_all_bfs {|node| puts node.node_name}
