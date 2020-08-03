import { xsuportal } from "./pb";
import { ApiError, ApiClient } from "./ApiClient";
import React from "react";
import { Redirect } from "react-router-dom";
import querystring from "querystring";

import { ErrorMessage } from "./ErrorMessage";
import { Index } from "./Index";

export interface Props {
  session: xsuportal.proto.services.common.GetCurrentSessionResponse;
  client: ApiClient;
  root: Index;
}

export interface State {
  session: xsuportal.proto.services.common.GetCurrentSessionResponse;
  error: Error | null;
  contestantId: string;
  password: string;
  requesting: boolean;
  loginSucceeded: boolean;
}

export class Login extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      session: this.props.session,
      error: null,
      contestantId: "",
      password: "",
      requesting: false,
      loginSucceeded: false,
    };
  }

  public componentDidMount() {}

  public render() {
    if (this.state.loginSucceeded) {
      const params = querystring.parse(window.location.search.slice(1));
      if (params.redirect) {
        console.log("redirect: ", params.redirect.toString());
        return <Redirect to={params.redirect.toString()}></Redirect>;
      } else {
        if (this.props.root.state.registered) {
          return <Redirect to="/"></Redirect>;
        } else {
          return (
            <>
              <article className="message is-success">
                <div className="message-header">
                  <p>参加登録してください</p>
                </div>
                <div className="message-body">
                  <p>
                    参加登録するには、
                    <a href="/registration">チームを新しく作成する</a>
                    か、招待URLから既存チームに参加してください。
                  </p>
                </div>
              </article>
            </>
          );
        }
      }
    } else {
      return (
        <>
          <header>
            <h1 className="title is-1">ログイン</h1>
          </header>
          <main>
            {this.renderError()}
            {this.renderForm()}
          </main>
        </>
      );
    }
  }

  public renderError() {
    if (!this.state.error) return;
    return <ErrorMessage error={this.state.error} />;
  }

  public renderForm() {
    return (
      <>
        <section className="columns mt-2">
          <form className="column is-half" onSubmit={this.onSubmit.bind(this)}>
            {this.renderFormFields()}
          </form>
        </section>
      </>
    );
  }

  public renderFormFields() {
    return (
      <>
        <div className="field">
          <label className="label" htmlFor="fieldContestantId">
            ログインID
          </label>
          <div className="control">
            <input
              className="input"
              type="text"
              required
              id="fieldContestantId"
              name="contestantId"
              autoComplete="username"
              onChange={this.onChange.bind(this)}
            />
          </div>
        </div>
        <div className="field">
          <label className="label" htmlFor="fieldPassword">
            パスワード
          </label>
          <div className="control">
            <input
              className="input"
              type="password"
              required
              id="fieldPassword"
              name="password"
              autoComplete="current-password"
              onChange={this.onChange.bind(this)}
            />
          </div>
        </div>
        <div className="field">
          <div className="control">
            <button className="button is-primary">ログイン</button>
          </div>
        </div>
      </>
    );
  }

  public onChange(event: React.FormEvent<HTMLInputElement>) {
    const target = event.target as HTMLInputElement;
    const value = target.value;
    const name = target.name;

    this.setState({
      [name]: value as unknown,
    } as Pick<State, keyof State>);
  }

  public async onSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (this.state.requesting) return;
    try {
      this.setState({ requesting: true });
      await this.login();
      this.props.root.setState({ loggedin: true });
      this.setState({ loginSucceeded: true, error: null, requesting: false });
    } catch (err) {
      this.setState({ error: err, requesting: false });
    }
  }

  login() {
    return this.props.client.login({
      contestantId: this.state.contestantId,
      password: this.state.password,
    });
  }
}
