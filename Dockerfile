ARG GITLAB_RUNNER_IMAGE_TYPE
ARG GITLAB_RUNNER_IMAGE_TAG
FROM gitlab/${GITLAB_RUNNER_IMAGE_TYPE}:${GITLAB_RUNNER_IMAGE_TAG}

RUN apt update && \
	apt upgrade && \
	apt install -y \
		build-essential \
		curl \
		wget \
		file \
		libxdo-dev \
		libssl-dev \
		libayatana-appindicator3-dev \
		librsvg2-dev \
		nsis llvm lld clang

ENV BASH_ENV ~/.bash_env
RUN touch "${BASH_ENV}" && echo '. "${BASH_ENV}"' >> ~/.bashrc && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE="${BASH_ENV}" bash && \
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh && \
	source ~/.bash_profile && \
	echo node > .nvmrc && \
	nvm install 22 && \
	corepack enable pnpm && \
	rustup target add x86_64-pc-windows-msvc

