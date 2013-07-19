module QuadrocopterDocs
	class Documentation

		# List all markdown files in docs/ folder
		def doclist
			Dir['docs/**/*.md']
		end

		# Requested file available?
		def contains(path)
			self.doclist.include? path
		end

		# Read markdown file and return as HTML
		def render(path)
			redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)
			redcarpet.render(File.read(path))
		end
	end
end