.PHONY: all deploy push serve status

all: deploy

# Package static site directly into local gh-pages branch
deploy:
	./deploy.sh

# Deploy to gh-pages and push to remote origin
push:
	./deploy.sh --push

# Launch local preview HTTP server on port 8000
serve:
	@echo "Serving Van Gogh Flow on http://localhost:8000 ..."
	python3 -m http.server 8000

# Inspect Git status across working tree and gh-pages branch
status:
	@git status
	@echo ""
	@echo "--- Branch refs ---"
	@git branch -v
