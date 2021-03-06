# frozen_string_literal: true

module MLibrarySearchParser
  module Transformer
    module Solr
      module Utilities
        # We don't escape double-quotes, parens because anything that's there
        # is already validated as part of a phrase
        LUCENE_SPECIAL_CHARS_RE = /([!{}\[\]^~?:])/.freeze

        def lucene_escape(str)
          str.gsub(LUCENE_SPECIAL_CHARS_RE, '\\\\\1')
              .gsub(/(?:\|\||&&)/, ' ')
        end

        def lucene_escape_node(node)
          node.deep_dup do |n|
            if n.is_type?(:tokens)
              n.class.new(lucene_escape(n.text))
            else
              n
            end
          end
        end
      end
    end
  end
end