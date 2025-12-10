# Nextflow Monorepo Example

This repository demonstrates how to set up and use a monorepo structure with multiple Nextflow pipelines in Seqera Platform.

## Repository Structure

```
monorepo-example/
├── nextflow.config          # Root-level config (required)
├── main.nf                  # Default workflow entry point
├── rnaseq/                  # RNA-seq pipeline
│   ├── main.nf
│   ├── nextflow.config
│   └── conf/
├── fetchngs/                # Fetch NGS pipeline
│   ├── main.nf
│   ├── nextflow.config
│   └── conf/
├── hello/                   # Hello world example
│   ├── main.nf
│   └── nextflow.config
├── rnaseq_schema.json       # Schema for rnaseq pipeline
└── fetchngs_schema.json     # Schema for fetchngs pipeline
```

## Key Requirements for Monorepos in Seqera Platform

### 1. Root-Level Configuration
- A `nextflow.config` file **must** exist in the repository root
- This root config should set `manifest.mainScript` to define a default workflow
- Alternatively, you can have an empty `main.nf` in the root (though this is less elegant)

### 2. Pipeline-Specific Configurations
- Each pipeline subdirectory (e.g., `rnaseq/`, `fetchngs/`) should have:
  - Its own `main.nf`
  - Its own `nextflow.config` (automatically recognized when launching that pipeline)

### 3. Schema Files Workaround
Seqera Platform looks for `nextflow_schema.json` in the repository root by default. For monorepos with multiple pipelines:

- Place pipeline-specific schema files in the **root directory** with naming pattern: `<pipeline_name>_schema.json`
  - Example: `rnaseq_schema.json`, `fetchngs_schema.json`
- These schema files enable Seqera Platform to build the input form for each pipeline

## Launching Pipelines in Seqera Platform

When adding a pipeline from this monorepo to the Launchpad:

### Basic Configuration

1. **Pipeline to launch**: Point to the repository URL
   ```
   https://github.com/laramiellindsey/monorepo-example
   ```

2. **Main script**: Specify the path to the pipeline's `main.nf` relative to the repository root
   ```
   rnaseq/main.nf
   ```
   or
   ```
   fetchngs/main.nf
   ```

3. The corresponding `nextflow.config` in the same directory as the `main.nf` will be automatically recognized

### Advanced Options

4. **Schema name**: Override the default `nextflow_schema.json` by specifying the pipeline-specific schema file
   ```
   rnaseq_schema.json
   ```
   or
   ```
   fetchngs_schema.json
   ```

## Example Configuration

For the RNA-seq pipeline:
- **Pipeline to launch**: `https://github.com/laramiellindsey/monorepo-example`
- **Main script**: `rnaseq/main.nf`
- **Schema name** (Advanced Options): `rnaseq_schema.json`

This configuration will:
- Use `rnaseq/main.nf` as the entry point
- Automatically load `rnaseq/nextflow.config`
- Use `rnaseq_schema.json` from the root to build the parameter form

## Troubleshooting

### Config File Not Found Error
If you see an error like:
```
ERROR ~ No such file or directory: Config file does not exist: /.nextflow/assets/laramiellindsey/monorepo-example/rnaseq/conf/base.config
```

Check that:
1. The path in your pipeline's `nextflow.config` uses correct relative paths
2. All referenced config files exist in the repository
3. The `includeConfig` statements in `nextflow.config` point to valid files

## Credits

Special thanks to:
- **Rob Syme** for guidance on monorepo configuration
- **Laramie** for setting up this example repository
- **Sushma** for initial testing and configuration

## Contributing

Feel free to fork this repository and submit pull requests with improvements or additional pipeline examples.
