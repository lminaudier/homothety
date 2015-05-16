module CoreExt
  refine String do
    def unindent
      gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "")
    end
  end
end
