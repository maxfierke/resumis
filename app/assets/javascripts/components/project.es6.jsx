class Project extends React.Component {
  constructor(props) {
    super(props);
  }

  getProjectClasses() {
    var cssClasses = "panel panel-default panel-project";

    if (this.props.endDate) {
      cssClasses += " past-projects";
    } else {
      cssClasses += " current-projects";
    }

    this.props.categories.forEach(function (currentValue, index, array) {
      cssClasses += " " + currentValue.slug;
    });

    return cssClasses;
  }

  render() {
    return (
      <section key={"project_" + this.props.id} className={this.getProjectClasses()}>
        <div className="panel-heading">
          <h4 className="panel-title clearfix">
            <div className="panel-left">
              {this.props.name}
              <ProjectStatus status={this.props.status} />
            </div>
            <div className="panel-right date-range">
              {this.props.dateRange}
            </div>
          </h4>
        </div>
        <div className="list-group">
          {this.props.descriptionHtml.length > 0 ? (
            <div className="list-group-item">
              <p dangerouslySetInnerHTML={
                { __html: this.props.descriptionHtml }
              }></p>
            </div>
          ) : null}
          {this.props.vimeoURL ? (
            <div className="list-group-item">
              <VimeoEmbed url={this.props.vimeoURL} />
            </div>
          ) : null}
          {this.props.youtubeURL ? (
            <div className="list-group-item">
              <YouTubeEmbed url={this.props.youtubeURL} />
            </div>
          ) : null}
          {this.props.soundcloudURL ? (
            <div className="list-group-item">
              <SoundcloudEmbed url={this.props.soundcloudURL} />
            </div>
          ) : null}
        </div>
        {this.props.links.map(function (item, index, array) {
          if (item.rel === "self") return undefined;

          return (
            <footer className="panel-footer">
              <ProjectLink href={item.href} rel={item.rel} label={item.label} />
            </footer>
          );
        })}
      </section>
    );
  }
};

Project.propTypes = {
  id: React.PropTypes.number,
  name: React.PropTypes.string,
  shortDescription: React.PropTypes.string,
  startDate: React.PropTypes.string,
  endDate: React.PropTypes.string,
  dateRange: React.PropTypes.string,
  descriptionHtml: React.PropTypes.string,
  description: React.PropTypes.string,
  status: React.PropTypes.shape({
    id: React.PropTypes.number,
    slug: React.PropTypes.string,
    name: React.PropTypes.string,
    createdAt: React.PropTypes.string,
    updateAt: React.PropTypes.string
  }),
  categories: React.PropTypes.arrayOf(React.PropTypes.object),
  vimeoUrl: React.PropTypes.string,
  youtubeURL: React.PropTypes.string,
  soundcloudURL: React.PropTypes.string,
  githubURL: React.PropTypes.string,
  bandcampURL: React.PropTypes.string,
  penflipURL: React.PropTypes.string
};
