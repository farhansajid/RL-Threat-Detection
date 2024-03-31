Q-Learning Agent

This repository contains a Python implementation of a Q-Learning agent using TensorFlow and OpenAI Gym.
Description

The Q-Learning algorithm is a model-free reinforcement learning technique used to learn optimal action-selection policies. In this implementation, the agent learns to interact with an environment provided by OpenAI Gym.
Usage

    Installation:
        Make sure you have Python installed.
        Install the required dependencies:

    pip install gym numpy tensorflow

Usage:

    Clone the repository:

    bash

git clone https://github.com/your-username/q-learning-agent.git

Navigate to the cloned directory:

bash

cd q-learning-agent

Run the training script:

python train.py

To test the trained agent, run:

        python test.py

Files

    q_learning_agent.py: Contains the implementation of the QLearningAgent class.
    train.py: Script to train the agent.
    test.py: Script to test the trained agent.
    rewards.csv: CSV file containing training rewards.

QLearningAgent Class
Constructor Parameters

    env: OpenAI Gym environment.
    alpha: Learning rate (default: 0.1).
    gamma: Discount factor (default: 0.99).
    epsilon: Exploration rate (default: 1.0).
    epsilon_decay: Decay rate of exploration rate (default: 0.99).
    min_epsilon: Minimum exploration rate (default: 0.01).

Methods

    act(state): Choose an action based on the current state.
    learn(state, action, reward, next_state, done): Update Q-values based on experience.
    train(episodes, render): Train the agent.
    test(episodes, render): Test the trained agent.

Acknowledgements

    This implementation is inspired by the Q-Learning algorithm and the OpenAI Gym environment.

License

This project is licensed under the MIT License - see the LICENSE file for details.
