
Built by https://www.blackbox.ai

---

# README.md for Vid-gen

## Project Overview
Vid-gen is a powerful project built to integrate advanced video mixing, workflow systems, and AI-driven content creation features into a cohesive platform named مُبدع AI. It combines various AI services from Google and other providers, making it an all-in-one solution for creating, managing, and enhancing multimedia content.

## Installation
To set up the Vid-gen project, you'll need to ensure you have Docker and Node.js installed. Follow these steps:

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd vid-gen
   ```

2. Install required dependencies:

   ```bash
   npm install
   ```

3. Create a `.env` file and add your environment-specific variables (ensure to include your API keys):

   ```bash
   # Example .env file
   SUPERMEMORY_API_KEY=your_supermemory_api_key
   OPERATIVE_API_KEY=your_operatives_api_key
   ```

4. Build and run the services:

   ```bash
   docker-compose up --build
   ```

5. Access the front-end application at `http://localhost:3000` and the backend API at `http://localhost:12000`.

## Usage
Once installed, you can launch the application, and the following commands provide access to its main features:

- Start the Plandex REPL interface:
  ```bash
  plandex
  ```

- Use the `plandex` command followed by the desired action:
  ```bash
  plandex new            # Start a new plan
  plandex load           # Load files/URIs into context
  plandex tell           # Describe a task to complete
  plandex apply          # Apply pending changes
  ```

## Features
- **Advanced Video Editing**: Integrate with Google's Veo-3 for professional-grade video generation and editing.
- **Workflow System**: Automate and manage creative processes.
- **Project Management**: Easily create, manage, and track various content projects.
- **Template Library**: Access and create reusable templates for content generation.
- **Analytics Dashboard**: View and analyze usage metrics and performance.

## Dependencies
The following dependencies are used in this project, primarily found in `package.json`:

- **@genkit-ai/mcp**: ^1.15.5
- Other libraries for AI, server handling, and data processing.

## Project Structure
Here's a brief overview of the project directory structure:

```
Vid-gen/
├── backend/                    # Backend service
│   ├── services/               # Contains service logic such as API integration
│   ├── routers/                # Handlers for specific API endpoints
│   ├── models/                 # Data models
│   └── main.py                 # Entry point for backend service
│
├── frontend/                   # Frontend application (React)
│   ├── src/                    # Source files for React
│   │   ├── components/         # Reusable components
│   │   ├── pages/              # Individual pages for the application
│   │   └── App.tsx             # Main app component
│   ├── public/                 # Public assets
│   └── index.js                # Entry point for React app
│
├── nginx/                      # Nginx configuration files
├── scripts/                    # Various scripts for setup and deployment
│   ├── deploy.sh               # Automated deployment script
└── docker-compose.yml          # Docker composition file for service orchestration
```

## Contributing
Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new Pull Request.

## License
This project is licensed under the MIT License. See the LICENSE file for more information.

## Contact
For queries or issues, please reach out via GitHub or contact the project maintainer directly. 

---

This README.md file provides a clear and comprehensive overview of how to use the Vid-gen project, its structure, dependencies, and installation procedures, aiming to make it easier for new users and contributors to understand and utilize the platform efficiently.