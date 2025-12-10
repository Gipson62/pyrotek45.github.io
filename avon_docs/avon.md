# Avon: Superpowers for Your Files

**Avon** is a tool that gives superpowers to your configuration files. It combines a functional programming language with a deployment system, allowing you to generate and manage hundreds of files from a single source of truth.

## What is Avon?

At its core, Avon solves the "copy-paste-modify" problem. Instead of maintaining 50 nearly identical YAML, JSON, or config files, you write one Avon program that generates them all.

It works with **any file format**—YAML, JSON, TOML, HCL, shell scripts, or even documentation.

## The Superpower: `@` Deployment

The magic of Avon is the `@` syntax. It lets you define exactly where a file should go, right inside the code that generates it.

```avon
let port = 8080 in
let env = "production" in

@/config/app.yaml {"
  server:
    port: {port}
    environment: {env}
    debug: {if env == "production" then "false" else "true"}
"}
```

When you run `avon --deploy`, this file is created instantly.

## Key Features

*   **Variables & Functions**: Don't repeat yourself. Define values once and use them everywhere.
*   **Logic**: Use `if/else`, `map`, and `filter` to dynamically generate configuration.
*   **Type Safety**: Avon checks your types before generating files, catching errors early.
*   **Git Deployment**: You can deploy directly from a git repository:
    ```bash
    avon --git user/repo --root ./output
    ```

## Why Use Avon?

1.  **Single Source of Truth**: Change a value in one place, update 100 files.
2.  **No More Typos**: Programmatic generation eliminates copy-paste errors.
3.  **Any Text File**: If it's text, Avon can generate it.

## Get Started

Avon is a single binary with no dependencies.

```bash
# 1. Create a file
echo 'let name = "World" in @/hello.txt "Hello, {name}!"' > hello.av

# 2. Deploy
avon hello.av --deploy --root ./output
```

Stop managing files by hand. Give them superpowers with Avon.
