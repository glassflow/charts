.PHONY: help lint lint-deps update-deps

# Default target
help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Chart linting
lint: lint-deps update-deps ## Lint Helm charts using chart-testing
	@echo "Running chart-testing lint..."
	ct lint --config ct.yaml

lint-deps: ## Check if required tools are installed
	@command -v helm >/dev/null 2>&1 || { echo "Error: helm is required but not installed. Aborting." >&2; exit 1; }
	@command -v ct >/dev/null 2>&1 || { echo "Error: ct (chart-testing) is required but not installed." >&2; \
		echo "Install it with: pip install chart-testing" >&2; exit 1; }
	@command -v python3 >/dev/null 2>&1 || { echo "Error: python3 is required but not installed. Aborting." >&2; exit 1; }
	@echo "All required tools are installed"

update-deps: ## Update Helm chart dependencies
	@echo "Updating Helm dependencies..."
	helm dependency update charts/glassflow-etl

