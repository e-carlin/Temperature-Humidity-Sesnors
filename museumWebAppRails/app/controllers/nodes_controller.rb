class NodesController < ApplicationController
	def index
		@nodes = Node.all
	end

	def show
		@node = Node.find(node_params[:id])
	end

	def update
		pp "&&&&&&&&&&&&"
		pp update_node_params
		pp "&&&&&&&&&&&&"
		@node = Node.find(node_params[:id])
		if @node.update_attributes(update_node_params)
			flash[:notice] = "Node name updated"
			redirect_to nodes_path
		else
			render('show')
		end
	end

	private
	  # Never trust parameters from the scary internet, only allow the white list through.
	  def node_params
	    params.permit(:id, :node)
	  end

	  def update_node_params
	  	params.require(:node).permit(:name)
	  end
end