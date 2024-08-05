import $ from "jquery";
import React from "react";
import ReactDOM from "react-dom";

import Container from "muicss/lib/react/container";
import Panel from "muicss/lib/react/panel";
import AppBar from "./components/app-bar";
import SideDrawer from "./components/side-drawer";
import Footer from "./components/footer";

import { setupSideDrawerTransition } from "./side-drawer-transition";
import { MENU_CATEGORIES, APP_NAME } from "./constants";

$(() => {
    ReactDOM.render(
        <div id="react-root">
            <SideDrawer pageName={APP_NAME} menuCategories={MENU_CATEGORIES} />
            <AppBar appName={APP_NAME} />
            <div id="content-wrapper">
                <div className="mui--appbar-height" />
                <Container className="main-container">
                    <Panel>
                        <h2>Welcome to Hashbash</h2>
                        <div className="mui-divider" />
                        <br />
                        <p>
                            This is a web-based rainbow table generator and
                            searcher implemented as a{" "}
                            <a href="https://go.dev">golang</a> backend and a{" "}
                            <a href="https://react.dev">react</a> frontend. It
                            is deployed on a raspberry pi running in my house.
                            Here&apos;s the{" "}
                            <a href="https://github.com/norwoodj/rpi-salt">
                                salt configuration
                            </a>{" "}
                            used to do that.
                        </p>
                        <p>
                            You can see the code for this project{" "}
                            <a href="https://github.com/norwoodj/hashbash-backend-go">
                                here
                            </a>
                            .
                        </p>
                        <p>
                            You might also visit my other projects{" "}
                            <a href="https://stupidchess.jmn23.com">
                                stupidchess
                            </a>{" "}
                            and <a href="https://bolas.jmn23.com">bolas</a>. My
                            personal website can be found{" "}
                            <a href="https://jmn23.com">here</a>. Here&apos;s a
                            link to my{" "}
                            <a href="https://github.com/norwoodj/docs/blob/master/docs/resume.md">
                                resume
                            </a>
                            .
                        </p>
                        <h3>Implementation</h3>
                        <p>
                            A rainbow table is a data structure that supports
                            the space and time efficient reversal of
                            cryptographic hash functions. For details on how
                            this works visit{" "}
                            <a href="https://en.wikipedia.org/wiki/Rainbow_table">
                                this article.
                            </a>
                        </p>
                        <p>
                            This implementation uses a postgresql database to
                            store and search the rainbow tables. The web
                            interface makes calls to the backend REST API to
                            generate tables and search existing ones. This is
                            certainly not the most efficient implementation of
                            rainbow tables possible or available. This was
                            simply a fun way to implement the algorithm in a
                            user-friendly way.
                        </p>
                        <p>What you can do from here:</p>
                        <ul>
                            <li>
                                <a href="/generate-rainbow-table">
                                    Generate a new Rainbow Table
                                </a>
                            </li>
                            <li>
                                <a href="/rainbow-tables">
                                    View Existing Rainbow Tables
                                </a>
                            </li>
                        </ul>
                    </Panel>
                </Container>
            </div>
            <div className="footer-height mui--hidden-md mui--hidden-lg mui--hidden-xl" />
            <Footer />
        </div>,
        document.getElementById("content-root")
    );

    setupSideDrawerTransition();
});
