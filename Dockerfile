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

ENV NVM_DIR=/root/.nvm

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
	bash -c "source $NVM_DIR/nvm.sh && nvm install -y 22" && \
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh && \
	source ~/.bash_profile && \
	corepack enable pnpm && \
	rustup target add x86_64-pc-windows-msvc

